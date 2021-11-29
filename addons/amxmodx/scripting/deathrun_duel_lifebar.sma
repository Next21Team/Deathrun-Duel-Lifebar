#include <amxmodx>
#include <fakemeta>
#include <deathrun_duel>

#define PLUGIN "Deathrun: Duel Lifebar"
#define VERSION "0.1"
#define AUTHOR "Psycrow"

#define COLORED_LIFEBAR
#define MAX_HEALTH	100

#if defined COLORED_LIFEBAR
    #define COLOR_RED Float: { 255.0, 0.0, 0.0 }
    #define COLOR_BLUE Float: { 0.0, 0.0, 255.0 }
    #define LIFEBAR_RENDERMODE kRenderTransTexture
    #define LIFEBAR_RENDERAMT 255.0
#endif
#define LIFEBAR_SCALE 0.2
new const LIFEBAR_MODEL[] = "sprites/next21_efk/lifebar_numeric.spr"

new g_iTELifebarEnt, g_iCTLifebarEnt, g_ptEnvSprite


public plugin_precache()
{
    precache_model(LIFEBAR_MODEL)
}

public plugin_init()
{
    register_plugin(PLUGIN, VERSION, AUTHOR)
    register_event("Health", "Event_ChangeHealth", "be")
    g_ptEnvSprite = engfunc(EngFunc_AllocString, "env_sprite")
}

public dr_duel_start(iPlayerCT, iPlayerTE)
{
    remove_all_lifebars()

    new iLifeBarTE = create_lifebar()
    if (iPlayerTE)
    {
        set_pev(iLifeBarTE, pev_aiment, iPlayerTE)
        #if defined COLORED_LIFEBAR
        set_pev(iLifeBarTE, pev_rendercolor, COLOR_RED)
        #endif
        g_iTELifebarEnt = iLifeBarTE
    }

    new iLifeBarCT = create_lifebar()
    if (iLifeBarCT)
    {
        set_pev(iLifeBarCT, pev_aiment, iPlayerCT)
        #if defined COLORED_LIFEBAR
        set_pev(iLifeBarCT, pev_rendercolor, COLOR_BLUE)
        #endif
        g_iCTLifebarEnt = iLifeBarCT
    }
}

public dr_duel_finish()
{
    remove_all_lifebars()
}

public dr_duel_canceled()
{
    remove_all_lifebars()
}

public Event_ChangeHealth(iPlayer)
{
    if (g_iCTLifebarEnt && pev(g_iCTLifebarEnt, pev_aiment) == iPlayer)
        update_lifebar(g_iCTLifebarEnt, get_user_health(iPlayer))
    else if (g_iTELifebarEnt && pev(g_iTELifebarEnt, pev_aiment) == iPlayer)
        update_lifebar(g_iTELifebarEnt, get_user_health(iPlayer))
}

remove_all_lifebars()
{
    remove_lifebar(g_iTELifebarEnt)
    remove_lifebar(g_iCTLifebarEnt)
    g_iTELifebarEnt = g_iCTLifebarEnt = 0   
}

create_lifebar()
{
    new iLifeBar = engfunc(EngFunc_CreateNamedEntity, g_ptEnvSprite)
    if (!pev_valid(iLifeBar))
        return 0

    engfunc(EngFunc_SetModel, iLifeBar, LIFEBAR_MODEL)
    set_pev(iLifeBar, pev_movetype, MOVETYPE_FOLLOW)
    set_pev(iLifeBar, pev_scale, LIFEBAR_SCALE)
    set_pev(iLifeBar, pev_effects, 0)
    set_pev(iLifeBar, pev_frame, MAX_HEALTH - 1.0)
    #if defined COLORED_LIFEBAR
    set_pev(iLifeBar, pev_rendermode, LIFEBAR_RENDERMODE)
    set_pev(iLifeBar, pev_renderamt, LIFEBAR_RENDERAMT)
    #else
    set_pev(iLifeBar, pev_rendermode, kRenderNormal)
    #endif

    return iLifeBar
}

update_lifebar(iLifeBar, iHealth)
{
    if (iHealth > MAX_HEALTH)
        iHealth = MAX_HEALTH

    set_pev(iLifeBar, pev_frame, iHealth * 100 / MAX_HEALTH - 1.0)
}

remove_lifebar(iLifeBar)
{
    if (iLifeBar)
        set_pev(iLifeBar, pev_flags, FL_KILLME)
}
