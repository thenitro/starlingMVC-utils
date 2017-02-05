package mvcutils.errors {
    public class MustBeOverridenError extends Error {
        public function MustBeOverridenError() {
            super("Must be overriden!");
        }
    }
}
