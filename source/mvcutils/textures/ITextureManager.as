package mvcutils.textures {
    import starling.textures.Texture;

    public interface ITextureManager {
        function getTexture(pTextureID:String):Texture;
    }
}
