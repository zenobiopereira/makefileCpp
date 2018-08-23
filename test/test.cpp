// tests.cpp

#include "../src/twoPlusThree.cpp"
#include "gtest/gtest.h"

TEST(AddFunctionTest, OneTest){
// Expected Success
	EXPECT_EQ(5, twoPlusThree(2,3));
}

TEST(AddFunctionTest, SecondTest){
// Expected Failure
	EXPECT_EQ(3, twoPlusThree(7,5));
}

int main(int argc, char **argv)	{
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}
