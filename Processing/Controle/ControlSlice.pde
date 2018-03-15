public class ControlSlice {
  ControlP5 myCP5;
  int id;
  String tag;
  PVector dim, pos;

  public ControlSlice(ControlP5 p5_, int id_, String tag_, PVector l_, PVector d_) {
    myCP5 = p5_;
    id = id_;
    tag = tag_;
    dim = new PVector();
    pos = new PVector();

    dim.set(d_);
    pos.set(l_);

    // padding
    float currX = int(dim.x/50);
    float currY = int(dim.x/50);

    // add the shit to the control object
    cp5.addTextfield("text"+id)
      .setPosition(pos.x+currX, pos.y+currY)
        .setSize((int)dim.x/3, (int)dim.x/12)
          .setFont(createFont("arial", 20))
            .setFocus(id==0)
              .setColor(color(255, 0, 0))
                .setId(id*100+0);

    currX += dim.x/3+dim.x/50;

    // add
    cp5.addBang("add"+id)
      .setPosition(pos.x+currX, pos.y+currY)
        .setSize((int)dim.x/5, (int)dim.x/12)
          .setId(id*100+1)
            .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


    currX += dim.x/5+dim.x/50;

    // delete
    cp5.addBang("del"+id)
      .setPosition(pos.x+currX, pos.y+currY)
        .setSize((int)dim.x/5, (int)dim.x/12)
          .setId(id*100+2)
            .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    currX += dim.x/5+dim.x/50;

    // create a toggle
    cp5.addToggle("toggle"+id)
      .setPosition(pos.x+currX, pos.y+currY)
        .setSize((int)dim.x/10, (int)dim.x/24)
          .setId(id*100+3);

    currX += dim.x/10+dim.x/50;
    currY += dim.x/12+dim.x/50;

    dim.set(dim.x, currY, 0);
  }

  //
  public PVector getDim() {
    return dim;
  }
  public PVector getPos() {
    return pos;
  }

  public void addSlider() {
    float dimy = dim.x/16;

    // TODO: figure out how to add multiple sliders
    cp5.addSlider("slider"+id)
      .setPosition(pos.x+dim.x/50, pos.y+dim.y)
        .setSize(int(dim.x*24/25), int(dimy))
          .setRange(0, 100).setValue(50);

    dim.set(dim.x, dim.y+dimy+dim.x/50, 0);

    // reposition the Label for controller 'slider'
    //cp5.getController("slider"+id).getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
    //cp5.getController("slider"+id).getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  }
}

