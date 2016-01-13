note
	description: "[
		Concrete representation of Randomizing features.
		]"

class
	RANDOMIZER

feature -- Numeric

	random_in_range (a_range: INTEGER_INTERVAL): INTEGER
			-- A `random_in_range' of `a_range'.
		do
			Result := random_number \\ (a_range.upper - a_range.lower) + 1 + a_range.lower
		end

feature {NONE} -- Implementation: Strings

	string_with_exception_removed (a_string: STRING; a_exception: CHARACTER): STRING
			-- A `string_with_exception_removed'--as in--`a_exception' removed from `a_string'.
		do
			Result := a_string.twin
			Result.replace_substring_all (a_exception.out, "")
		end

feature {NONE} -- Implementation: Random

	random_digit_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_digit_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Digits)
		end

	random_a_to_z_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_a_to_z_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Alphabet_lower)
		end

	random_a_to_z_upper_with_exceptions (a_exceptions: STRING): CHARACTER
			-- A `random_a_to_z_upper_with_exceptions' found in `a_exceptions'.
		do
			Result := random_with_exceptions (a_exceptions, Alphabet_lower).as_upper
		end

	random_with_exceptions (a_exceptions, a_string: STRING): CHARACTER
			-- A `random_with_exceptions' based on `a_exceptions' from `a_string'.
		require
			has_exceptions: not a_exceptions.is_empty
			exceptions_are_digits: across a_exceptions as ic_exception all digits.has (ic_exception.item) end
		do
			from Result := a_exceptions [1] until not a_exceptions.has (Result)
			loop
				Result := a_string [random_in_range (1 |..| a_string.count)]
			end
		ensure
			no_exceptions: not a_exceptions.has (Result)
		end

	random_digit: CHARACTER
			-- A `random_digit' from `digits'.
		do
			Result := Digits [random_in_range (1 |..| Digits.count)]
		end

	random_a_to_z_lower: CHARACTER
			-- A `random_a_to_z_lower' case.
		do
			Result := Alphabet_lower [random_in_range (1 |..| Alphabet_lower.count)]
		end

	random_a_to_z_upper: CHARACTER
			-- A `random_a_to_z_upper' case.
		do
			Result := random_a_to_z_lower.as_upper
		end

	random_character_from_string (a_string: STRING): CHARACTER
			-- A `random_character_from_string'.
		do
			Result := a_string [random_in_range (1 |..| a_string.count)]
		end

	random_number: INTEGER
			-- A new `random_number' based on `random_sequence'.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

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
