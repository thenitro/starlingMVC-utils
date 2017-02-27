package mvcutils.errors {
    public class MustBeOverridenError extends Error {
        private static const MESSAGE:String = "Must be overriden!";

        public function MustBeOverridenError() {
            super(MESSAGE);
        }
    }
}
