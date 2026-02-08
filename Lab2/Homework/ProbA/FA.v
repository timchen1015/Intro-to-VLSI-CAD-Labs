module FA(
    input  a,
    input  b,
    input  cin, 
    output sum,
    output cout
);

//put your design here

wire w1, w2, w3;
and(w1, a, b);
and(w2, b, cin);
and(w3, a, cin);
or(cout, w1, w2, w3);
xor(sum, a, b, cin);

endmodule
