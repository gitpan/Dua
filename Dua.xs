#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include "dua.h"

extern char *dua_errstr;
extern char **dua_pos;

MODULE = Dua PACKAGE = Dua

PROTOTYPES: ENABLE

void
dua_init()
CODE:
     /* initialize initial "position" in the DIT */
     /* any call requiring a DN will start from the ROOT until
      * the user calls dua_moveto.
      */
     if ((dua_pos = (char **) malloc (sizeof (char **))) == NULL)
	  fatal (DUA_ERR_MALLOC);
     *dua_pos = NULL;

     /* initialize default values for asynchronous timeout */
     dua_settmout(30L,0L);
    
char *
dua_errstr()
CODE:
   RETVAL = dua_errstr;
OUTPUT:
   RETVAL

int
dua_settmout (sec, usec)
long sec
long usec
 
int
dua_open (dsa, port, dn, passwd)
char *dsa
int port
char *dn
char *passwd


int
dua_modrdn (dn, newrdn)
char *dn
char *newrdn

int
dua_delete (rdn)
char *rdn

int
dua_close ()

int
dua_moveto (dn)
char *dn

int 
dua_add (rdn, ...)
char *rdn
CODE:
{
  atlist_t *atlist;
  register int i;
  if ((items - 1) % 2 != 0) 
  {
    croak ("Number of attribute/value pairs must be even");
  }
  atlist = NULL;
  for(i=1;i<items;(i++,i++))
    dua_addpair(&atlist,(char *)SvPV(ST(i), na),(char *)SvPV(ST(i+1), na));
  RETVAL = dua_add (rdn, atlist);
  dua_freelist (atlist);
}
OUTPUT:
  RETVAL

int 
dua_modattr (rdn, ...)
char *rdn
CODE:
{
  atlist_t *atlist;
  register int i;
  if ((items - 1) % 2 != 0) 
  {
    croak ("Number of attribute/value pairs must be even");
  }
  atlist = NULL;
  for(i=1;i<items;(i++,i++))
    dua_addpair(&atlist,(char *)SvPV(ST(i), na),(char *)SvPV(ST(i+1), na));
  RETVAL = dua_modattr (rdn, atlist);
  dua_freelist (atlist);
}
OUTPUT:
  RETVAL

void
dua_find (rdn, filter, scope, all)
char *rdn
char *filter
int scope
int all
PREINIT:
  atlist_t *	atlist;
  register atlist_t *temp;
PPCODE:
  atlist = (atlist_t *) 0;
  dua_find(rdn,filter,scope,1,all,&atlist);
  temp = atlist;
  while (temp != NULL) 
  {
    XPUSHs(sv_2mortal(newSVpv(temp->attr,0)));
    XPUSHs(sv_2mortal(newSVpv(temp->value,0)));
    temp = temp->next;
  }
  dua_freelist (atlist);


void
dua_show (rdn)
char *rdn
PREINIT:
  atlist_t *	atlist;
  register atlist_t *temp;
PPCODE:
  atlist = (atlist_t *) 0;
  dua_find(rdn,NULL,0,0,0,&atlist);
  temp = atlist;
  while (temp != NULL) 
  {
    XPUSHs(sv_2mortal(newSVpv(temp->attr,0)));
    XPUSHs(sv_2mortal(newSVpv(temp->value,0)));
    temp = temp->next;
  }
  dua_freelist (atlist);
