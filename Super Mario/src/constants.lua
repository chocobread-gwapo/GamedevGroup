window_width = 1280
window_height = 720

virtual_width = 256
virtual_height = 144

tile_size = 16

screen_tile_width = virtual_width / tile_size
screen_title_height = virtual_height / tile_size

camera_speed = 100

background_scroll_speed = 10 

tile_set_width = 5 
tile_set_height = 4

tile_sets_wide = 6
tile_sets_tall = 10 

topper_sets_wide = 6 
topper_sets_tall = 18

topper_sets = topper_sets_wide * topper_sets_tall
tile_sets = tile_sets_wide * tile_sets_tall

player_walk_speed = 60

player_jump_velocity = -150

snail_move_speed = 10

tile_id_empty = 5
tile_id_ground = 3

collidable_tiles = {
    tile_id_ground
}

bush_ids = {
    1, 2, 5, 6, 7
}

coin_ids = {
    1, 2, 3
}

crates = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
}

gems = {
    1, 2, 3, 4, 5, 6, 7, 8
}

jump_blocks = {}

for i = 1, 30 do 
    table.insert(jump_blocks, i)
end


keys_locks = {
    1, 2, 3, 4
}
 
key_id = 0
lock_id = 4

flag_posts = {
    1, 2, 3, 4, 5, 6
}

flags = {
    7, 16, 25, 34
}

flag_offset = 9 

level_width = 25
