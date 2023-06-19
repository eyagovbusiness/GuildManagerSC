using FluentValidation;

namespace APIGateway.Summaries
{
    public class TestSummary : FluentValidation.AbstractValidator<TestSummary>
    {
        public int Numb;
        public TestSummary()
        {
            //RuleFor(x => x.Numb).
        }
    }
}
