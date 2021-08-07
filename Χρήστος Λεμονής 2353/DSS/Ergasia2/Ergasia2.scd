/*Να φτιάξετε 20 ήχους στο SuperCollider χρησιμοποιώντας τεχνικές σύνθεσης ήχου όπως Modulation Synthesis (Ring, AM, FM, PhM) καθώς και Waveshaping synthesis technique.
Οι 10 ήχοι θα είναι από MS και οι υπόλοιποι 10 από Waveshaping.

Για το waveshaping θα χρησιμοποιήσετε 2 μεθόδους. Τη μέθοδο Signal στέλνοντας  asWavetable μήνυμα, και τη μέθοδο με Buffer object στέλνοντας μηνύματα όπως ( sine1, sine2, sine3, cheby, κτλ )*/

(
SynthDef(\ring1, {
var carrier, modulator, env;

env = EnvGen.ar(Env.triangle(2,1));
carrier = SinOsc.ar(350,0,0.5) * env;
modulator = SinOsc.ar(5,0,0.5); //bipolar

Out.ar([0,1],carrier*modulator);
}).play;
)

(
SynthDef(\ring2, {
var carrier, modulator, carrfreq, modfreq, env;

env = EnvGen.ar(Env.triangle(5,1));

carrier= SinOsc.ar(123,0,0.5) * env;
modulator= SinOsc.ar(1,0,0.5); //bipolar

Out.ar([0,1],carrier*modulator);
}).play;
)

(
SynthDef(\ring3, {
var carrier, modulator, carrfreq, modfreq, env;

env = EnvGen.ar(Env.triangle(3,1));

carrier= SinOsc.ar(520,0,0.5) * env;
modulator= SinOsc.ar(2,0,0.5); //bipolar

Out.ar([0,1],carrier*modulator);
}).play;
)

(
SynthDef(\am1, {
var carrier, modulator, env;

env = EnvGen.ar(Env.triangle(2,1));

carrier= SinOsc.ar(689,0,0.5) * env;
modulator= SinOsc.ar(9,0,0.5,0.5); //unipolar

Out.ar([0,1],carrier*modulator);
}).play;
)

(
SynthDef(\am2, {
var carrier, modulator, env;

env = EnvGen.ar(Env.triangle(1.5,1));

carrier= SinOsc.ar(512,0,0.5) * env;
modulator= SinOsc.ar(6,0,0.5,0.5); //unipolar

Out.ar([0,1],carrier*modulator);
}).play;
)


(
SynthDef(\am3, {
var carrier, modulator, carrfreq, modfreq, env;

env = EnvGen.ar(Env.triangle(5,1));

carrier= SinOsc.ar(712,0,0.5) * env;
modulator= SinOsc.ar(1,0,0.5,0.5); //unipolar

Out.ar([0,1],carrier*modulator);
}).play;
)

(
SynthDef(\fm1, {
var modulator,carrier, env;

env = EnvGen.ar(Env.triangle(3,1));

modulator = SinOsc.ar(10, 0, 100, 500 );
carrier = SinOsc.ar(modulator, 0, 0.5) * env;

Out.ar([0,1],carrier);
}).play;
)

(
SynthDef(\fm2, {
var modulator,carrier, env;

env = EnvGen.ar(Env.triangle(2,1));

modulator = SinOsc.ar(120, 0, 150, 20 );
carrier = SinOsc.ar(modulator, 0, 0.5) * env;

Out.ar([0,1],carrier);
}).play;
)

(
SynthDef(\PhM, {
var ph, env;

ph = SinOsc.ar(440, SinOsc.ar(150,0,150*5),0.25);
env = EnvGen.ar(Env.triangle(2,1));

Out.ar([0,1],ph*env);
}).play;
)

(
SynthDef(\PhM2, {
var ph, env;

ph = SinOsc.ar(440, SinOsc.ar(650,0,650*2),0.25);
env = EnvGen.ar(Env.triangle(2,1));

Out.ar([0,1],ph*env);
}).play;
)

========================================

(
b = Buffer.alloc(s, 512, 1, { |buf| buf.sine1Msg(0.1/[1,2,3,4,5])});
SynthDef(\bf1 ,{|freq = 320 , amp = 0.5|
	var env , sh;
	env = EnvGen.kr(Env.perc);
	sh = Shaper.ar(b , SinOsc.ar(freq, 0, Saw.ar(220,0.4))+WhiteNoise.ar(0.1), amp);
	Out.ar([0,1],env*sh)
}).play;
)

(
b = Buffer.alloc(s , 512 , 1 , { |buf| buf.sine2Msg([200,1000],[4,0.5])});
SynthDef(\bf2 , { |freq = 580 , amp = 1|
	var env , sh;
	env = EnvGen.kr(Env.triangle(2));
	sh = Shaper.ar(b , SinOsc.ar(Pulse.ar(freq , 0.6 , amp),0,0.4));
	Out.ar([0,1],env*sh)
}).play;
)

(
b = Buffer.alloc(s , 512 , 1 ,{ |buf| buf.sine1Msg(0.4/[0.1,0.4,0.6,0.7,0.5])});
SynthDef(\bf3 , {|freq = 290 , amp = 0.6|
	var env , sh;
	env = EnvGen.kr(Env.perc(0.3,0.6));
	sh = Shaper.ar(b , FreeVerb.ar(Decay.ar(SinOsc.ar(freq),0.4,LFCub.ar(500 ,0 , 0.3)),0.5,0.7,0.6));
	Out.ar([0,1],env*sh)
}).play;
)

(
b = Buffer.alloc(s , 512 , 1 ,{|buf| buf.chebyMsg([1,1,0,1,0,0])});
SynthDef(\bf4 , {
	var env , sh ;
	env = EnvGen.kr(Env.circle([0.3,3,2,4,0],[1,2,1,2,1]));
	sh = Shaper.ar(b,LFCub.ar(40,0,Line.kr(0,0.9,2)),0.5);
	Out.ar([0,1],env*sh)
}).play;
)

(
b = Buffer.alloc(s , 512 , 1 , {|buf| buf.sine3Msg([20,40,60],[0.4,0.6,0.7])});
SynthDef(\bf5 , { |freq = 300 , amp = 0.8|
	var env , sh ;
	env = EnvGen.kr(Env.triangle(6));
	sh = Shaper.ar(b ,(SinOsc.ar(freq, Saw.ar(Line.kr(5, 3000, 9)), amp)));
	Out.ar([0,1],env*sh)
}).play;
)

(
~sig = Signal.sineFill(1025, [1,2,3,4,5] , [1,0.5,0.1,6,0.8]);
~sig.asWavetableNoWrap;
~sig.size;
~table = Buffer.loadCollection(s,~sig);
SynthDef(\wv1 , {|freq = 440 , amp = 0.4|
	var env , wv;
	env = EnvGen.kr(Env.perc);
	wv =  Shaper.ar(~table , Saw.ar(SinOsc.ar(freq,0,0.02),amp ));
	Out.ar([0,1],env*wv)
}).play;
)

(
~sig = Signal.sineFill(512 , [0.4,0.9,5] , [1,0.4,0.07]);
~sig.asWavetableNoWrap;
~sig.size;
~table = Buffer.loadCollection(s , ~sig);
SynthDef(\wv2 , {|freq = 800 , amp = 0.3|
	var env , wv;
	env = EnvGen.kr(Env.adsr(0.5 , 0.2));
	wv = Shaper.ar(~table , Impulse.ar(MouseX.kr(100 , 6000) , 0 ,MouseY.kr(0.1 ,1 )));
		Out.ar([0,1],env*wv)
}).play;
)

(
~tables = Env([0.4,0.1,0.9] , [0.5,0.5] , [4,-4]).asSignal(1025);
~tables = ~tables.asWavetableNoWrap;
~tableB = Buffer.loadCollection(s , ~tables);
SynthDef(\wv3 ,{
	var env , wv;
	env = EnvGen.kr(Env.asr);
	wv = Shaper.ar(~tableB ,LFNoise2.ar(440 , XLine.kr(100,500),0.04));
	Out.ar([0,1] , env*wv)
}).play
)

(
~sig = Signal.sineFill(1024 , [0.3,0.4,2 , 4] , [0.1,0.4,0.09,0.36]);
~sig.asWavetableNoWrap;
~sig.size;
~table = Buffer.loadCollection(s , ~sig);
SynthDef(\wv4 ,{
	var env , wv;
	env = EnvGen.kr(Env.adsr);
	wv = Shaper.ar(~table ,Ringz.ar(Dust.ar(2.5 , 0.4),XLine.kr(100 , 2000 , 6,0.4) , 0.4 , 0.6));
	Out.ar([0,1] , env*wv)
}).play
)

(
~tables2 = Env([0.7,0.06,0.4,0.012,0.7] , [1,1] , [-5,5]).asSignal(1025);
~tables2 = ~tables2.asWavetableNoWrap;
~tableBuf = Buffer.loadCollection(s , ~tables2);
SynthDef(\wv5 ,{
	var env , wv;
	env = EnvGen.kr(Env.adsr);
	wv = Shaper.ar(~tableBuf ,Impulse.ar(880 , 0 , 0.4 ) + SinOsc.ar(XLine.kr(70 , 10000,11),0.3));
	Out.ar([0,1] , env*wv)
}).play
)