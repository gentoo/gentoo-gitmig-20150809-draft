# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/db4-fix.eclass,v 1.2 2003/05/25 21:06:23 pauldv Exp $
#
# Author: Paul de Vrieze <pauldv@gentoo.org>
#
# This eclass is meant to fix configure scripts to work with our versioned db4
#
# the dodb4-fix script should be run from the directory where autoconf needs to
# be run from

ECLASS=db4-fix
INHERITED="$INHERITED $ECLASS"

newdepend "sys-apps/sed"

DESCRIPTION="Based on the ${ECLASS} eclass"

EDB4_FIX_VERSION=0.1

dodb4-fix () {
	postfix=`grep "#define.db_create" /usr/include/db4/db.h \
		|cut -d " " -f 2|sed -e "s,db_create,,"`

	if [ $# -ne 1 ];then
		die "This function needs as argument the name of the file to fix"
	fi
	if has_version =sys-libs/db-4*; then
		if [ "`basename $1`" == "configure" ]; then
			die "sorry configure fixing is not supported yet"
		else
			einfo "fixing $1 to work with db-4 by appending ${postfix}"
			cp $1 ${1}.cpy
			cat ${1}.cpy \
				|sed -e "s;\( *AC_CHECK_LIB( *db-?4? *, db_[^ ,]*\);\1${postfix};" \
				-e "s/\(-l\|[ \t]\)\(db3\)\([ \t]\)/\1db-3\3/g" \
				>${1} || die "sed failed"
#				-e "s/\( *AC_CHECK_LIB([^,]*, db_create\)\( *,\)/\1${postfix}\2/" \

			autoconf
		fi
	else
		einfo "db4 not found, so not applying db4 fixes"
	fi

}
