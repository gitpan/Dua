package Dua;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require Exporter;
require DynaLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw();
@EXPORT_OK = qw(dua_errstr dua_settmout dua_open dua_modrdn dua_delete
		dua_close dua_moveto dua_add dua_modattr dua_show dua_find);

$VERSION = '1.0';

bootstrap Dua $VERSION;

# Preloaded methods go here.

dua_init();

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Dua - DUA/Perl interface to an X.500 directory

=head1 SYNOPSIS

  use Dua qw(dua_open dua_moveto dua_modrdn dua_delete 
	     dua_add dua_modattr dua_show dua_find
	     dua_close dua_settmout dua_errstr);

=head1 DESCRIPTION

  This module provides a set of subroutines which allow a Perl script to
  access to the X.500 directory.

=head1 SUBROUTINES

  dua_open($dsa, $port, $dn, $passwd)

      Open an association to the DSA  specified  in  dsa  and
      running  on  the  port specified by port. If no port is
      specified, then  duaperl  will  use  the  default  port
      number.  duaperl  will bind to the DSA as dn, using the
      credentials supplied in passwd. Currently, only  simple
      authentication is supported.

  dua_moveto($dn)

      Move to the location in the DIT specified by dn.

  dua_modrdn($rdn, $newrdn)

      Modify the object whose RDN is rdn to newrdn.

  dua_delete($rdn)

      Delete the object specified by rdn from the DIT.

  dua_add($rdn, %attrs)

      Add a new object to the DIT with an RDN of rdn with the
      attributes attrs.

  dua_modattr($rdn, %attrs)

      Modify the object specified by rdn with the  attribute-
      value pairs in attrs.

  dua_show($rdn)

      Returns in an  associative  array  the  attribute-value
      pairs found in the object specified by rdn.

  dua_find($rdn, $filter, $scope, $all)

      Returns in an associative array the attribute-value pairs found
      beneath the object specified by rdn. filter is a string
      representation of a filter to apply to the search.  A
      Backus-Naur Form definition is given below.  scope refers to how
      deep the search is to progress in the DIT. A value of 0
      specifies the immediate children of the object; a value of 1
      specifies the entire sub- tree beneath the object.  all refers
      to what will be returned in the associative array. A value of 0
      will return just the DN's of matching objects, keyed by their
      ordinality in the search response; a value of 1 specifies that
      the attribute-value pairs of all match- ing objects are to be
      returned.  This routine is used for non-leaf objects.

  dua_close()

      This routine closes the association to the X.500 DSA.

  dua_settmout($seconds, $microseconds)

      This routine sets the asynchronous timeout value for
      all operations.  The default is 30 seconds.

  dua_errstr()

      This routine returns a description of the problem when an error
      occurs.

=head1 NOTES

 dua_moveto() determines the path which is prepended to the rdn of all
 other functions. This simulates ``standing'' at a particular position
 in the DIT, and being able to specify DN's relative to the current
 position. If a fully-qualified DN is more appropriate for a
 particular call, begin the rdn string with an `@' character.

 The Backus-Naur Form (BNF) for the filter specified in dua_find()
 is as follows:

             <filter> ::= '(' <filtercomp> ')'
             <filtercomp> ::= <and> | <or> | <not> | <simple>
             <and> ::= '&' <filterlist>
             <or> ::= '|' <filterlist>
             <not> ::= '!' <filter>
             <filterlist> ::= <filter> | <filter> <filterlist>
             <simple> ::= <attributetype> <filtertype> <attributevalue>
             <filtertype> ::= '=' | '~=' | '<=' | '>='

=head1 RETURN VALUES

  All routines except dua_show() and dua_find() will return 1 on
  success, 0 otherwise. For those routines which return associative
  arrays ( dua_show() and dua_find() ), the array is returned
  empty if an error occurs. The description of the problem may be
  obtained by use of dua__errstr().


=head1 AUTHOR

  Converted from duaperl Version 1.0a3 to a Perl 5 module by 
  Stephen Pillinger, School of Computer Science, 
  The University of Birmingham, UK.

  duaperl was written by Eric W. Douglas, California State University,
  Fresno.

=head1 SEE ALSO

perl(1), ldap(3).

=cut
