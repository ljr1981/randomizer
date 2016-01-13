note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	RANDOMIZER_TEST_SET

inherit
	EQA_TEST_SET
		select
			default_create
		end

	EQA_COMMONLY_USED_ASSERTIONS
		rename
			assert as unused_assert,
			default_create as unused_default_create
		end

feature -- Test routines

	integer_test
		note
			testing:
				"covers/{RANDOMIZER}.random_integer"
		local
			one, two: INTEGER
		do
			across
				1 |..| 100_000 as ic
			from
				one := 0
			loop
				two := Randomizer.random_integer
				assert_integers_not_equal ("one_not_two", one, two)
				one := two
			end
		end

	real_test
		note
			testing:
				"covers/{RANDOMIZER}.random_real"
		local
			one, two: REAL_64
		do
			across
				1 |..| 1_000 as ic
			from
				one := 0.00
			loop
				two := Randomizer.random_real
				assert_not_equal ("one_not_two", one, two)
				one := two
			end
		end

	integer_range_test
		note
			testing:
				"covers/{RANDOMIZER}.random_integer_in_range"
		do
			across 1 |..| 1_000 as ic loop
				assert ("1_000_integers_in_range", (50 |..| 100).has (randomizer.random_integer_in_range (50 |..| 100)))
			end
		end

	real_range_test
		note
			testing:
				"covers/{RANDOMIZER}.random_real_in_range"
		local
			l_number: REAL_64
		do
			across 1 |..| 100_000 as ic loop
				randomizer.random_real_in_range (50 |..| 100).do_nothing
			end
			across 1 |..| 100 as ic loop
				randomizer.random_real_in_range (0 |..| 1).do_nothing
			end
		end

	unique_test
		note
			testing:
				"covers/{RANDOMIZER}.unique_array"
		do
			randomizer.unique_array (five_numbers, lotto_range).do_nothing
		end

	random_a_to_z_lower_test
		note
			testing:
				"covers/{RANDOMIZER}.random_a_to_z_lower"
		do
			randomizer.random_a_to_z_lower.do_nothing
		end

	random_a_to_z_upper_test
		note
			testing:
				"covers/{RANDOMIZER}.random_a_to_z_upper"
		do
			randomizer.random_a_to_z_upper.do_nothing
		end

	random_a_to_z_upper_with_exceptions_test
		note
			testing:
				"covers/{RANDOMIZER}.random_a_to_z_upper_with_exceptions"
		do
			randomizer.random_a_to_z_upper_with_exceptions ("AQRST").do_nothing
		end

	random_a_to_z_with_exceptions_test
		note
			testing:
				"covers/{RANDOMIZER}.random_a_to_z_with_exceptions"
		do
			randomizer.random_a_to_z_with_exceptions ("aqrst").do_nothing
		end

	random_character_from_string_test
		note
			testing:
				"covers/{RANDOMIZER}.random_character_from_string"
		do
			randomizer.random_character_from_string ("abcdefg").do_nothing
		end

	random_digit_test
		note
			testing:
				"covers/{RANDOMIZER}.random_digit"
		do
			randomizer.random_digit.do_nothing
		end

	random_digit_with_exceptions_test
		note
			testing:
				"covers/{RANDOMIZER}.random_digit_with_exceptions"
		do
			randomizer.random_digit_with_exceptions ("345").do_nothing
		end

	random_with_exceptions_test
		note
			testing:
				"covers/{RANDOMIZER}.random_with_exceptions"
		do
			randomizer.random_with_exceptions ("345", "0123456789").do_nothing
		end

	random_sentence_test
		note
			testing:
				"covers/{RANDOMIZER}.random_sentence"
		do
			Randomizer.random_sentence.do_nothing
		end

	random_paragraph_test
		note
			testing:
				"covers/{RANDOMIZER}.random_paragraph"
		do
			Randomizer.random_paragraph.do_nothing
		end

	random_city_name_test
		note
			testing:
				"covers/{RANDOMIZER}.random_city_name"
		do
			Randomizer.random_city_name.do_nothing
		end

	random_address_test
		note
			testing:
				"covers/{RANDOMIZER}.random_address"
		do
--			print (Randomizer.random_address)
--			assert ("False", False)
			Randomizer.random_address.do_nothing
		end

feature {NONE} -- Implementation

	five_numbers: INTEGER = 3

	lotto_range: INTEGER_INTERVAL
		once
			Result := 1 |..| 69
		end

	randomizer: RANDOMIZER
			-- For testing
		once
			create Result
		end
end


