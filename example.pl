#!/bham/pd/bin/perl -w
#
# This is a just a quick example to illustrate the use of the Dua module.
#
use Dua qw(dua_open dua_find dua_show dua_close);

# Where to contact...

$dsa = "ldap.cs.bham.ac.uk";
$port = undef;                # Defaults to "ldap"

# Who to bind as...anonymous in this case...
$bind_dn = "";
$bind_passwd = "";

# Attempt to bind to the DSA...

dua_open($dsa, $port, $bind_dn, $bind_passwd) || 
     die("Can't connect to  DUA: ",Dua::dua_errstr());

# Where to search from...
$base = "\@c=gb\@o=The University of Birmingham\@ou=Computer Science";

# What to search for...
$filter="sn=Pillinger";

$scope = 1;     # Search the entire sub-tree.
$all = 0;       # Only return the DN's of matching objects.

# Do the search

%results = dua_find($base, $filter,$scope,$all);

if (! %results ) 
{
  print "Nothing found\n";
  dua_close();
  exit;
}

print "Found ",scalar keys %results," match(es) \n\n";

# Look up each DN and extract a value...

foreach $dn (values %results)
{
  print $dn,"\n";

  # The DN will need reversing and separating by @'s. The ldap stuff seems
  # to put quotes around entries with spaces in them, so they need removing.

  $dn = "@" . join("@",reverse(split(/,\s*/,$dn)));
  $dn =~ s/\"//g;

  %results = dua_show($dn);
  if (! %results)
  { print "No details found\n"; }
  else 
  {
    print $results{"sn"},"\n";
  }
}
print "\n";
dua_close();
