package mvcutils.errors {
    public class StaticError extends Error {
        public function StaticError() {
            super(this + " is static!");
        }
    }
}
