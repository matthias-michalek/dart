function draw_coms(coms)
    coms_r = reduce(hcat,reshape(coms,(:,1)))'
    Plots.scatter!([0],[0],label="")
    Plots.scatter!(coms_r[:,1],coms_r[:,2],label="")    
end

function reset_plot()
    Plots.plot()
end

function draw_circle(x0,y0,r)
    ϕ = LinRange(0,2π,500)
    x = x0 .+ sin.(ϕ)*r
    y = y0.+ cos.(ϕ)*r

    Plots.plot!(x,y,aspect_ratio=:equal,color="black",label="")
end

function draw_circles(rb_i,rb_o,ri_i,ri_o,ro_i,ro_o)
    draw_circle(0,0,rb_i)
    draw_circle(0,0,rb_o)

    draw_circle(0,0,ri_i)
    draw_circle(0,0,ri_o)

    draw_circle(0,0,ro_i)
    draw_circle(0,0,ro_o)
end

function draw_line(ri,ro,phi)
    x = [ri,ro] * cos(phi)
    y = [ri,ro] * sin(phi)

    Plots.plot!(x,y,color="black",label="")
end

function draw_lines(ri,ro,phis)
    for phi in phis
        draw_line(ri,ro,phi) 
    end   
end

function draw_board(rs, phis)
    rb_i,rb_o,ri_i,ri_o,ro_i,ro_o = rs
    draw_lines(rb_o,ro_o,phis)
    draw_circles(rb_i,rb_o,ri_i,ri_o,ro_i,ro_o)
end

function draw_annotation(r,phis,dphi,vals)

    xs = @. r * cos(phis+dphi/2)
    ys = @. r * sin(phis+dphi/2)

    Plots.annotate!(xs,ys,vals)
end