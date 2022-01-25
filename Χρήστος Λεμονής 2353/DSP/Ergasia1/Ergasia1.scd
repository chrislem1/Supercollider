/*Κατασκευάστε 20 ήχους με χρήση τεχνικών όπως προσθετική σύνθεση και Phase Vocoder στο SuperCollider. Για την προσθετική σύνθεση μπορείτε να χρησιμοποιήσετε περιοδικούς ταλαντωτές όπως για παράδειγμα, ημιτονοειδής, πριονωτή, τριγωνική κυματομορφή κλπ, καθώς και γεννήτριες θορύβου (noise generators) όπως λευκός θόρυβος, ροζ θόρυβος κλπ. Χρησιμοποιήστε ηχογραφημένους ήχους για Phase vocoder.
Οι ήχοι αυτοί θα χωρίζονται σε 2 χρονικές κατηγορίες: 10 sustained 10 short*/

/*Όλοι οι ήχοι έχουνε envelope, προσθετική σύνθεση και το \sus7 έχει και το phase vocoder. Επίσης έχω δώσει σε όλα τις ίδιες μεταβλητές sin και env οπου στο sin βρίσκεται ο ήχος (ημιτονα,τριγωνικη κυματομορφή,γεννήτριες θορύβου κλπ), και στο env βρίσκεται το envelope οπου καθορίζει την ένταση ανάλογα τον χρόνο και κατα συνέπεια αν θα είναι sustained η short. Όλα έχουνε και ένα Output (Out.ar) όπου εκεί δηλώνω τα κανάλια που θα βγεί ο ήχος (left, right(0,1)) και ενώνω το env με το sin  για να παίξουν μαζί και να βγεί το αποτέλεσμα στην έξοδο και να το ακούσουμε με το .play*/

(
SynthDef(\sus1, {
	var sin, env;
	env = EnvGen.ar(Env.linen(2,1,3,1));
	sin = SinOsc.ar([180,120,694,531]) + Saw.ar(20,0.5);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef(\sus2, {
	var sin, env;
	env = EnvGen.ar(Env.linen(2,1,4,1));
	sin = Klang.ar(`[[100, 500, 100],[0.2, 0.3, 0.1],nil], 1, 0) * 0.4 + Saw.ar(50,0.1);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef(\sus3, {
	var env,sin;
	env = EnvGen.ar(Env.triangle(4,1));
	sin = Blip.ar([10,20],100,) + LFNoise2.ar(200);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef(\sus4, {
	var env,sin;
	env = EnvGen.ar(Env.new([1,2,0],[3,2]));
	sin = LFNoise2.ar([600,430,268]) + LFPar.ar([50,100]);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef (\sus5, {
	var env, sin;
	env = EnvGen.ar(Env.new([0.3,2,0.2,2,0.3,2,0.3,0],[3,2]));
	sin = FreeVerb.ar(Crackle.ar(1),0.6,1.6,0.4) + SinOsc.ar([20,40],0,0.5);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef (\sus6, {
	var env, sin;
	env = EnvGen.ar(Env.triangle(3,1));
	sin = Pulse.ar([60,70,93,21],0.1);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
c.free; c = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
SynthDef(\sus7, {
    var rec, env, sin;
    rec = PlayBuf.ar(1, c, BufRateScale.kr(c));
	env = EnvGen.ar(Env.new([0,4,0],[4,1]));
	sin = LFTri.ar([500,800,456,1000],0.2,1) + PinkNoise.ar(0.4,0);
	Out.ar([0,1],rec*env*sin);
}).play;
)//sustained phase vocoder

(
SynthDef (\sus8, {
	var env, sin;
	env = EnvGen.ar(Env.sine(3,0.5));
	sin = LFCub.ar([530]) + SinOsc.ar([265/2]);
	Out.ar([0,1],env*sin);
}).play;
) //sustained

(
SynthDef (\sus9, {
	var env, sin;
	env = EnvGen.ar(Env.triangle(3,1));
	sin = VarSaw.ar([20,21,22,23,24,25],0,0.1,2) + LFNoise1.ar(30,1);
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef (\sus10, {
	var env, sin;
	env = EnvGen.ar(Env.sine(2,0.1));
	sin = SyncSaw.ar([200,300],540) + BrownNoise.ar(0.8) ;
	Out.ar([0,1],env*sin);
}).play;
)//sustained

(
SynthDef(\short1, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.1,0.7,2,-8));
	sin = SinOsc.ar([600,400,700]) + PinkNoise.ar ;
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short2, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.01,0.6,1));
	sin = LFTri.ar(40,20,60) + LFPulse.ar(90);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short3, {
	var sin, env;
	env = EnvGen.ar(Env.sine(0.15));
	sin = SinOsc.ar([400,800]) + LFNoise1.ar(200);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short4, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.04,0.7));
	sin = LFPar.ar([200,400]) + LFDNoise0.ar(3000);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short5, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.01,0.5));
	sin = Blip.ar([1000,500,1500]);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short6, {
	var sin, env;
	env = EnvGen.ar(Env.linen(0.01,0.05,0.5));
	sin = SyncSaw.ar([100,250],100) + Dust.ar(1500);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short7, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.02));
	sin = VarSaw.ar([632,764]) + Blip.ar(123);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short8, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.01,0.5));
	sin = LFPar.ar([38,42]);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short9, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.1,0.5));
	sin = LFSaw.ar([75,100]);
	Out.ar([0,1],env*sin);
}).play;
)//short

(
SynthDef(\short10, {
	var sin, env;
	env = EnvGen.ar(Env.perc(0.1,0.4));
	sin = FSinOsc.ar([120,190]);
	Out.ar([0,1],env*sin);
}).play;
)//short