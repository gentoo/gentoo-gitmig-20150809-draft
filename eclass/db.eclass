# This is a common location for functions used in the sys-libs/db ebuilds
# $Header: /var/cvsroot/gentoo-x86/eclass/db.eclass,v 1.1 2003/08/21 09:53:43 robbat2 Exp $

ECLASS=db
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS db_fix_so

db_fix_so () {
	cd ${ROOT}/usr/lib
	for ext in so a; do
		for name in libdb libdb_cxx libdb_tcl libdb_java; do
			target=`find -type f -maxdepth 1 -name "${name}-*.${ext}" |sort -g |tail -n 1`
			[ -n "${target}" ] && ln -sf ${target//.\//} ${name}.${ext}
		done;
	done;

	cd ${ROOT}/usr/include
	target=`find -type d -maxdepth 1 -name 'db*' | sort  -g |cut -d/ -f2- | tail -n1`
	[ -n "${target}" ] && ln -sf ${target}/db.h .
	[ -n "${target}" ] && ln -sf ${target}/db_185.h .
}
