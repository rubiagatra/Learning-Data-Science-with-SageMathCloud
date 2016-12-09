︠a03eb245-f373-40b9-b85f-d723df67155f︠


def sierpinski(N):
    return [([0] * (N // 2 - a // 2)) + [binomial(a, b) % 2 for b in range(a + 1)] + ([0] * (N // 2 - a // 2)) for a in range(0, N, 2)]

@interact
def _(N=slider([2 ** a for a in range(12)], label='Number of iterations', default=64), size=slider(1, 20, label='Size', step_size=1, default=9)):
    M = sierpinski(2 * N)
    matrix_plot(M, cmap='binary').show(figsize=[size, size])
︡7bfe594f-b13a-4dde-b59c-5e3ea5c1b89f︡{"interact":{"controls":[{"animate":true,"control_type":"slider","default":6,"display_value":true,"label":"Number of iterations","vals":["1","2","4","8","16","32","64","128","256","512","1024","2048"],"var":"N","width":null},{"animate":true,"control_type":"slider","default":8,"display_value":true,"label":"Size","vals":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"],"var":"size","width":null}],"flicker":false,"id":"6ca52442-8ec1-480b-ba6b-4d443161c2c0","layout":[[["N",12,null]],[["size",12,null]],[["",12,null]]],"style":"None"}}︡{"done":true}︡
︠f0e34da9-c00a-4f43-82bf-565afc6e0f6fs︠



@interact
def polar_prime_spiral(start=1, end=2000, show_factors = false, highlight_primes = false, show_curves=true, n = 0):

    #For more information about the factors in the spiral, visit http://www.dcs.gla.ac.uk/~jhw/spirals/index.html by John Williamson.

    if start < 1 or end <=start: print "invalid start or end value"
    if n > end: print "WARNING: n is greater than end value"
    def f(n):
        return (sqrt(n)*cos(2*pi*sqrt(n)), sqrt(n)*sin(2*pi*sqrt(n)))

    list =[]
    list2=[]
    if show_factors == false:
        for i in [start..end]:
            if i.is_pseudoprime(): list.append(f(i-start+1)) #Primes list
            else: list2.append(f(i-start+1)) #Composites list
        P = points(list)
        R = points(list2, alpha = .1) #Faded Composites
    else:
        for i in [start..end]:
            list.append(disk((f(i-start+1)),0.05*pow(2,len(factor(i))-1), (0,2*pi))) #resizes each of the dots depending of the number of factors of each number
            if i.is_pseudoprime() and highlight_primes: list2.append(f(i-start+1))
        P = plot(list)
        p_size = 5 #the orange dot size of the prime markers
        if not highlight_primes: list2 = [(f(n-start+1))]
        R=points(list2, hue = .1, pointsize = p_size)

    if n > 0:
        print 'n =', factor(n)

        p = 1
    #The X which marks the given n
        W1 = disk((f(n-start+1)), p, (pi/6, 2*pi/6))
        W2 = disk((f(n-start+1)), p, (4*pi/6, 5*pi/6))
        W3 = disk((f(n-start+1)), p, (7*pi/6, 8*pi/6))
        W4 = disk((f(n-start+1)), p, (10*pi/6, 11*pi/6))
        Q = plot(W1+W2+W3+W4, alpha = .1)

        n=n-start+1        #offsets the n for different start values to ensure accurate plotting
        if show_curves:
            begin_curve = 0
            t = var('t')
            a=1
            b=0
            if n > (floor(sqrt(n)))^2 and n <= (floor(sqrt(n)))^2 + floor(sqrt(n)):
                c = -((floor(sqrt(n)))^2 - n)
                c2= -((floor(sqrt(n)))^2 + floor(sqrt(n)) - n)
            else:
                c = -((ceil(sqrt(n)))^2 - n)
                c2= -((floor(sqrt(n)))^2 + floor(sqrt(n)) - n)
            print 'Pink Curve:  n^2 +', c
            print 'Green Curve: n^2 + n +', c2
            def g(m): return (a*m^2+b*m+c);
            def r(m) : return sqrt(g(m))
            def theta(m) : return r(m)- m*sqrt(a)
            S1 = parametric_plot(((r(t))*cos(2*pi*(theta(t))),(r(t))*sin(2*pi*(theta(t)))), begin_curve, ceil(sqrt(end-start)), rgbcolor=hue(0.8), thickness = .2) #Pink Line

            b=1
            c= c2;
            S2 = parametric_plot(((r(t))*cos(2*pi*(theta(t))),(r(t))*sin(2*pi*(theta(t)))), begin_curve, ceil(sqrt(end-start)), rgbcolor=hue(0.6), thickness = .2) #Green Line

            show(R+P+S1+S2+Q, aspect_ratio = 1, axes = false)
        else: show(R+P+Q, aspect_ratio = 1, axes = false)
    else: show(R+P, aspect_ratio = 1, axes = false)
︡9cd33cec-5608-4799-8f5b-1f94329dba24︡{"interact":{"controls":[{"control_type":"input-box","default":1,"label":"start","nrows":1,"readonly":false,"submit_button":null,"type":null,"var":"start","width":null},{"control_type":"input-box","default":2000,"label":"end","nrows":1,"readonly":false,"submit_button":null,"type":null,"var":"end","width":null},{"control_type":"checkbox","default":false,"label":"show_factors","readonly":false,"var":"show_factors"},{"control_type":"checkbox","default":false,"label":"highlight_primes","readonly":false,"var":"highlight_primes"},{"control_type":"checkbox","default":true,"label":"show_curves","readonly":false,"var":"show_curves"},{"control_type":"input-box","default":0,"label":"n","nrows":1,"readonly":false,"submit_button":null,"type":null,"var":"n","width":null}],"flicker":false,"id":"ee24364d-f148-4ba5-98cc-e734a5e25771","layout":[[["start",12,null]],[["end",12,null]],[["show_factors",12,null]],[["highlight_primes",12,null]],[["show_curves",12,null]],[["n",12,null]],[["",12,null]]],"style":"None"}}︡{"done":true}︡
︠087b82b3-744a-45da-84a1-2dd378bca7cas︠

@interact
def diffie_hellman(bits=slider(8, 513, 4, 8, 'Number of bits', False),
    button=selector(["Show new example"],label='',buttons=True)):
    maxp = 2 ^ bits
    p = random_prime(maxp)
    k = GF(p)
    if bits > 100:
        g = k(2)
    else:
        g = k.multiplicative_generator()
    a = ZZ.random_element(10, maxp)
    b = ZZ.random_element(10, maxp)

    html("""
<style>
.gamodp, .gbmodp {
color:#000;
padding:5px
}
.gamodp {
background:#846FD8
}
.gbmodp {
background:#FFFC73
}
.dhsame {
color:#000;
font-weight:bold
}
</style>
<h2 style="color:#000;font-family:Arial, Helvetica, sans-serif">%s-Bit Diffie-Hellman Key Exchange</h2>
<ol style="color:#000;font-family:Arial, Helvetica, sans-serif">
<li>Alice and Bob agree to use the prime number p = %s and base g = %s.</li>
<li>Alice chooses the secret integer a = %s, then sends Bob (<span class="gamodp">g<sup>a</sup> mod p</span>):<br/>%s<sup>%s</sup> mod %s = <span class="gamodp">%s</span>.</li>
<li>Bob chooses the secret integer b=%s, then sends Alice (<span class="gbmodp">g<sup>b</sup> mod p</span>):<br/>%s<sup>%s</sup> mod %s = <span class="gbmodp">%s</span>.</li>
<li>Alice computes (<span class="gbmodp">g<sup>b</sup> mod p</span>)<sup>a</sup> mod p:<br/>%s<sup>%s</sup> mod %s = <span class="dhsame">%s</span>.</li>
<li>Bob computes (<span class="gamodp">g<sup>a</sup> mod p</span>)<sup>b</sup> mod p:<br/>%s<sup>%s</sup> mod %s = <span class="dhsame">%s</span>.</li>
</ol>
    """ % (bits, p, g, a, g, a, p, (g^a), b, g, b, p, (g^b), (g^b), a, p,
       (g^ b)^a, g^a, b, p, (g^a)^b))
︡aaed6eaf-5aa1-4e16-aff7-acd70b85cc2f︡{"interact":{"controls":[{"animate":true,"control_type":"slider","default":0,"display_value":false,"label":"Number of bits","vals":["8","12","16","20","24","28","32","36","40","44","48","52","56","60","64","68","72","76","80","84","88","92","96","100","104","108","112","116","120","124","128","132","136","140","144","148","152","156","160","164","168","172","176","180","184","188","192","196","200","204","208","212","216","220","224","228","232","236","240","244","248","252","256","260","264","268","272","276","280","284","288","292","296","300","304","308","312","316","320","324","328","332","336","340","344","348","352","356","360","364","368","372","376","380","384","388","392","396","400","404","408","412","416","420","424","428","432","436","440","444","448","452","456","460","464","468","472","476","480","484","488","492","496","500","504","508","512"],"var":"bits","width":null},{"button_classes":null,"buttons":true,"control_type":"selector","default":0,"label":"","lbls":["Show new example"],"ncols":null,"nrows":null,"var":"button","width":null}],"flicker":false,"id":"bde30426-e9de-4cff-9ea2-8787609495e4","layout":[[["bits",12,null]],[["button",12,null]],[["",12,null]]],"style":"None"}}︡{"done":true}︡
︠7ab98ef0-8c2e-4f2c-b58c-c2bfb0629363︠









