
/************************************************************************
* dua.h: Common definitions for DUAP
************************************************************************/

#ifndef _DUA_H
#define _DUA_H

/****
	added by S.M.Pillinger
 ****/

#define fatal croak

/************************************************************************
* GLOBAL TYPE DECLARATIONS
************************************************************************/
#include <sys/time.h>

typedef struct atlist {
     char *attr;
     char *value;
     struct atlist *next;
} atlist_t;

#ifndef POSIX
char *strdup();
#endif /* not POSIX */

/************************************************************************
* GLOBAL DEFINES
************************************************************************/
#ifndef DUA_GIVEUP
#define DUA_GIVEUP 3		/* no. of rev's to make on ret. values */
#endif /* DUA_GIVEUP */

#ifndef u_int
#define u_int	unsigned int
#define u_long	unsigned long
#endif /* u_int */

#define DUA_ERR_MALLOC	"Couldn't allocate some critical memory."

/************************************************************************
* FUNCTION TYPES
************************************************************************/
int dua_settmout (/* sec, usec */);
int dua_open (/* dsa, port, dn, passwd */);
int dua_modrdn (/* dn, newrdn */);
int dua_delete (/* rdn */);
int dua_close (/*  */);
int dua_moveto (/* dn */);
static int set_ldap_err (/* err */);
int dua_quoteme (/* value */);
char * dua_mkdn (/* dn */);
void dua_addpair (/* atlist, attr, value */);
void dua_freelist (/* atlist */);
int dua_add (/* rdn, attrs */);
int  dua_modattr (/* rdn, attrs */);
char * ntoa (/* n */);
int dua_find (/* rdn, filter, scope, find, all, attrs */);
char ** split_multi (/* val */);
void free_vector (/* vec */);
char ** dishdn2dn (/* dn */);
int init_duaperl(/*  */);
static int usersub(/* ix, sp, items */);
static int userset (/* ix, str */);
static int userval (/* ix, str */);

#endif /* _DUA_H */
