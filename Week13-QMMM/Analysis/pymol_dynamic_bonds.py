from pymol import cmd

# 加载轨迹文件
cmd.load("/home/hh2635/comp-lab-class/comp-lab-class-2024/Week13-QMMM/Analysis/trajectory.pdb", "traj")

# 设置整体显示为 cartoon
cmd.hide("everything")
cmd.show("cartoon", "all")

# 配体和附近 3 Å 的残基设置为 sticks
cmd.select("ligand", "resname CHA")
cmd.select("nearby", "byres (ligand around 3)")
cmd.show("sticks", "ligand or nearby")

# 配体颜色为 cyan，附近残基颜色为 magenta
cmd.color("cyan", "ligand")
cmd.color("magenta", "nearby")

# sticks 显示原子颜色
cmd.set("stick_color", "atomic", "ligand or nearby")

# 反应前截图
cmd.frame(1)  # 第一帧
cmd.png("/home/hh2635/comp-lab-class/comp-lab-class-2024/Week13-QMMM/Figures/reaction_before.png")

# 反应后截图
cmd.frame(cmd.count_states("traj"))  # 最后一帧
cmd.png("/home/hh2635/comp-lab-class/comp-lab-class-2024/Week13-QMMM/Figures/reaction_after.png")

# 动态生成键和更新颜色
for frame in range(1, cmd.count_states("traj") + 1):
    cmd.frame(frame)
    cmd.delete("temp_bond")
    cmd.bond("id 5663", "id 5675", order=1, name="temp_bond")  # 替换为目标原子 ID
    cmd.color("blue", "temp_bond")  # 动态键颜色为蓝色

# 保存电影和 PyMOL 会话
cmd.mpng("/home/hh2635/comp-lab-class/comp-lab-class-2024/Week13-QMMM/Figures/dynamic_bonds_movie")  # 保存每帧的截图，用于生成电影
cmd.save("/home/hh2635/comp-lab-class/comp-lab-class-2024/Week13-QMMM/Figures/reaction_movie.pse")  # 保存 PyMOL 会话
