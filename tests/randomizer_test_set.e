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

	randomizer_tests
			-- New test routine
		local
			l_rand: RANDOMIZER
		do
			do_nothing
		end

end


