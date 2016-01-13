note
	description: "[
		Concrete representation of Randomizing features.
		]"
	synopsis: "[
		The features of this class represent various applications
		of having access to a `random_integer' and `random_integer_in_range'.
		From these two features, we can ask for random characters
		from various sets of characters (like A-Z, a-z, and 0-9).
		]"

class
	RANDOMIZER

feature -- Random Numbers

	random_real: REAL_64
			-- A new `random_real' based on `random_sequence'.
		do
			Random_sequence.forth
			Result := Random_sequence.double_item
		end

	random_integer: INTEGER
			-- A new `random_integer' based on `random_sequence'.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_integer_in_range (a_range: INTEGER_INTERVAL): INTEGER
			-- A `random_integer_in_range' of `a_range'.
		do
			Result := random_integer \\ (a_range.upper - a_range.lower) + 1 + a_range.lower
		ensure
			in_range: a_range.has (Result)
		end

	random_real_in_range (a_range: INTEGER_INTERVAL): REAL_64
			-- A `random_real_in_range' of `a_range'.
		do
			Result := random_real * (a_range.upper.to_double - a_range.lower.to_double) + a_range.lower.to_double
		ensure
			ranged: (Result >= a_range.lower.to_double) and (Result <= a_range.upper.to_double)
		end

	unique_array (a_capacity: INTEGER; a_range: INTEGER_INTERVAL): ARRAYED_LIST [INTEGER]
			-- A `unique_array' of `a_capacity' as a list of `random_integer' items.
		local
			l_number, v: INTEGER
		do
			create Result.make (a_capacity)
			across 1 |..| a_capacity as ic loop
				from
					v := a_capacity * 100
					l_number := random_integer \\ (a_range.upper - a_range.lower) + 1 + a_range.lower
				variant
					v
				until
					not Result.has (l_number) or Result.is_empty
				loop
					v := v - 1
					l_number := random_integer \\ (a_range.upper - a_range.lower) + 1 + a_range.lower
				end
				Result.force (l_number)
			end
		ensure
			capacity: Result.count = a_capacity
			unique_content: across Result as ic_list all Result.occurrences (ic_list.item) = 1 end
		end

feature -- Random Characters

	random_digit: CHARACTER
			-- A `random_digit' from `digits'.
		do
			Result := Digits [random_integer_in_range (1 |..| Digits.count)]
		ensure
			contains_digit: Digits.has (Result)
		end

	random_a_to_z_lower: CHARACTER
			-- A `random_a_to_z_lower' case.
		do
			Result := Alphabet_lower [random_integer_in_range (1 |..| Alphabet_lower.count)]
		ensure
			contains_lower: Alphabet_lower.has (Result)
		end

	random_a_to_z_upper: CHARACTER
			-- A `random_a_to_z_upper' case.
		do
			Result := random_a_to_z_lower.as_upper
		ensure
			contains_upper: Alphabet_lower.has (Result.as_lower)
		end

	random_character_from_string (a_string: STRING): CHARACTER
			-- A `random_character_from_string'.
		do
			Result := a_string [random_integer_in_range (1 |..| a_string.count)]
		ensure
			in_string: a_string.has (Result)
		end

feature -- Randoms with Exceptions

	random_digit_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_digit_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Digits)
		ensure
			no_exceptions: not a_exceptions.has (Result)
		end

	random_a_to_z_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_a_to_z_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Alphabet_lower)
		ensure
			no_exceptions: not a_exceptions.has (Result)
		end

	random_a_to_z_upper_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_a_to_z_upper_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Alphabet_lower.as_upper)
		ensure
			no_exceptions: not a_exceptions.has (Result)
		end

	random_with_exceptions (a_exceptions, a_string: STRING): CHARACTER
			-- A `random_with_exceptions' based on `a_exceptions' from `a_string'.
		require
			has_exceptions: not a_exceptions.is_empty
			exceptions_in_string: across a_exceptions as ic_exception all a_string.has (ic_exception.item) end
		do
			from Result := a_exceptions [1] until not a_exceptions.has (Result)
			loop
				Result := a_string [random_integer_in_range (1 |..| a_string.count)]
			end
		ensure
			no_exceptions: not a_exceptions.has (Result)
		end

feature {NONE} -- Implementation

	random_sequence: RANDOM
			-- Random sequence
		local
			l_time: TIME
			l_seed: INTEGER
		once
				-- This computes milliseconds since midnight.
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second
			create Result.set_seed (l_seed)
		end

feature -- Constants

	alphabet_lower: STRING = "abcdefghijklmnopqrstuvwxyz"

	alpha_vowels: STRING = "aeiouy"

	alpha_consonents: STRING = "bcdfghjklmnpqrstvwxz"

	digits: STRING = "0123456789"

end
