require 'test_helper'

class TileGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tile_group = tile_groups(:one)
  end

  test "should get index" do
    get tile_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_tile_group_url
    assert_response :success
  end

  test "should create tile_group" do
    assert_difference('TileGroup.count') do
      post tile_groups_url, params: { tile_group: { i_1ind: @tile_group.i_1ind, i_age7: @tile_group.i_age7, i_age8: @tile_group.i_age8, i_basr: @tile_group.i_basr, i_prop: @tile_group.i_prop, idk: @tile_group.idk, ind_age1: @tile_group.ind_age1, ind_age2: @tile_group.ind_age2, ind_age3: @tile_group.ind_age3, ind_age4: @tile_group.ind_age4, ind_age5: @tile_group.ind_age5, ind_age6: @tile_group.ind_age6, ind_age7: @tile_group.ind_age7, ind_age8: @tile_group.ind_age8, ind_r: @tile_group.ind_r, ind_srf: @tile_group.ind_srf, men: @tile_group.men, men_1ind: @tile_group.men_1ind, men_5ind: @tile_group.men_5ind, men_basr: @tile_group.men_basr, men_coll: @tile_group.men_coll, men_occ5: @tile_group.men_occ5, men_prop: @tile_group.men_prop, men_surf: @tile_group.men_surf, nbcar: @tile_group.nbcar } }
    end

    assert_redirected_to tile_group_url(TileGroup.last)
  end

  test "should show tile_group" do
    get tile_group_url(@tile_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_tile_group_url(@tile_group)
    assert_response :success
  end

  test "should update tile_group" do
    patch tile_group_url(@tile_group), params: { tile_group: { i_1ind: @tile_group.i_1ind, i_age7: @tile_group.i_age7, i_age8: @tile_group.i_age8, i_basr: @tile_group.i_basr, i_prop: @tile_group.i_prop, idk: @tile_group.idk, ind_age1: @tile_group.ind_age1, ind_age2: @tile_group.ind_age2, ind_age3: @tile_group.ind_age3, ind_age4: @tile_group.ind_age4, ind_age5: @tile_group.ind_age5, ind_age6: @tile_group.ind_age6, ind_age7: @tile_group.ind_age7, ind_age8: @tile_group.ind_age8, ind_r: @tile_group.ind_r, ind_srf: @tile_group.ind_srf, men: @tile_group.men, men_1ind: @tile_group.men_1ind, men_5ind: @tile_group.men_5ind, men_basr: @tile_group.men_basr, men_coll: @tile_group.men_coll, men_occ5: @tile_group.men_occ5, men_prop: @tile_group.men_prop, men_surf: @tile_group.men_surf, nbcar: @tile_group.nbcar } }
    assert_redirected_to tile_group_url(@tile_group)
  end

  test "should destroy tile_group" do
    assert_difference('TileGroup.count', -1) do
      delete tile_group_url(@tile_group)
    end

    assert_redirected_to tile_groups_url
  end
end
