# This is a common location for functions used in the sys-libs/db ebuilds
# $Header: /var/cvsroot/gentoo-x86/eclass/db.eclass,v 1.3 2003/08/21 11:04:54 robbat2 Exp $

ECLASS=db
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS db_fix_so db_src_install_doc db_src_install_usrbinslot db_src_install_headerslot db_src_install_usrlibcleanup

db_fix_so () {
	cd ${ROOT}/usr/lib

	# first clean up old symlinks
	find ${ROOT}/usr/lib -type l -name 'libdb*.so' -exec rm \{} \;
	find ${ROOT}/usr/lib -type l -name 'libdb*.a' -exec rm \{} \;

	# now rebuild all the correct ones
	for ext in so a; do
		for name in libdb libdb_cxx libdb_tcl libdb_java; do
			target=`find -type f -maxdepth 1 -name "${name}-*.${ext}" |sort -g |tail -n 1`
			[ -n "${target}" ] && ln -sf ${target//.\//} ${name}.${ext}
		done;
	done;

	# do the same for headers now
	# but since there are only two of them, just overwrite them
	cd ${ROOT}/usr/include
	target=`find -type d -maxdepth 1 -name 'db*' | sort  -g |cut -d/ -f2- | tail -n1`
	if [ -n "${target}" ]; then
		ln -sf ${target}/db.h .
		ln -sf ${target}/db_185.h .
	fi
}

db_src_install_doc() {
	# not everybody wants this wad of documentation as it is primarily API docs
	if use doc; then
		dodir /usr/share/doc/${PF}/html
		mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html/
		rm -rf ${D}/usr/docs
	else
		rm -rf ${D}/usr/docs
	fi
}

db_src_install_usrbinslot() {
	# slot all program names to avoid overwriting
	for fname in ${D}/usr/bin/db_*
	do
		mv ${fname} ${fname//\/db_/\/db${SLOT}_}
	done
}

db_src_install_headerslot() {
	# install all headers in a slotted location
	dodir /usr/include/db${SLOT}
	mv ${D}/usr/include/*.h ${D}/usr/include/db${SLOT}/
}

db_src_install_usrlibcleanup() {
	# this is handled by db_fix_so now
	#ln -s /usr/include/db${SLOT}/db.h ${D}/usr/include/db.h
	
	# we remove all symlinks created in here, as our db_fix_so will re-create them
	#find ${D}/usr/lib -type l -name 'libdb*.so' -exec rm \{} \;
	#find ${D}/usr/lib -type l -name 'libdb*.a' -exec rm \{} \;

	# this actually does all the work for us, so let's reduce code duplication
	ROOT=${D} db_fix_so
}
