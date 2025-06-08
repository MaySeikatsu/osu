using osu.Framework.Graphics;
using osu.Framework.Graphics.Sprites;
using osu.Game.Overlays.Settings.Sections.Toy;
using System;
using System.Collections.Generic;
using System.Text;
using osu.Framework.Localisation;

namespace osu.Game.Overlays.Settings.Sections
{
    class ToySection : SettingsSection
    {
        public override LocalisableString Header => "Toy";

        public override Drawable CreateIcon() => new SpriteIcon
        {
            Icon = FontAwesome.Solid.PepperHot
        };

        public ToySection()
        {
            Children = new Drawable[]
            {
                new IntifaceSettings(),
            };
        }
    }
}
