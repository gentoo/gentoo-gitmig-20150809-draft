# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome2.eclass,v 1.33 2003/05/04 18:58:55 liquidx Exp $
#
# Authors:
# Bruce A. Locke <blocke@shivan.org>
# Spidler <spidler@gentoo.org>

inherit libtool gnome.org

# accept both $DEBUG and USE="debug"
[ -n "$DEBUG" -o -n "`use debug`" ] && inherit debug

# Gnome 2 ECLASS
ECLASS="gnome2"
INHERITED="$INHERITED $ECLASS"

G2CONF=""               # extra configure opts passed to econf
ELTCONF=""              # extra options passed to elibtoolize
SCROLLKEEPER_UPDATE="1" # whether to run scrollkeeper for this package
USE_DESTDIR=""          # use make DESTDIR=${D} install rather than einstall

[ -n "$DEBUG" -o -n "`use debug`" ] && G2CONF="${G2CONF} --enable-debug=yes"

gnome2_src_configure() {
	elibtoolize ${ELTCONF}
	# doc keyword for gtk-doc
	use doc \
		&& G2CONF="${G2CONF} --enable-gtk-doc" \
		|| G2CONF="${G2CONF} --disable-gtk-doc"

	econf ${@} ${G2CONF} || die "./configure failure"

}

gnome2_src_compile() {

	gnome2_src_configure ${@}
	emake || die "compile failure"

}

gnome2_src_install() {

	# if this is not present, scrollkeeper-update may segfault and
	# create bogus directories in /var/lib/
	dodir /var/lib/scrollkeeper

	# we must delay gconf schema installation due to sandbox
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"

	if [ -z "${USE_DESTDIR}" -o "${USE_DESTDIR}" = "0" ]; then
		einstall " scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ " ${@}
	else
		make DESTDIR=${D} \
			scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper \
			${@} install
	fi

	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	# manual document installation
	[ -n "${DOCS}" ] && dodoc ${DOCS}

	# do not keep /var/lib/scrollkeeper because:
	# 1. scrollkeeper will get regenerated at pkg_postinst()
	# 2. ${D}/var/lib/scrollkeeper contains only indexes for the current pkg
	#    thus it makes no sense if pkg_postinst ISN'T run for some reason.

	if [ -z "`find ${D} -name '*.omf'`" ]; then
		export SCROLLKEEPER_UPDATE="0"
	fi

	# regenerate these in pkg_postinst()
	rm -rf ${D}/var/lib/scrollkeeper
}


gnome2_gconf_install() {
	if [ -x ${ROOT}/usr/bin/gconftool-2 ]
	then
		unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
		export GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
		einfo "installing gnome2 gconf schemas"	
		cat ${ROOT}/var/db/pkg/*/${PN}-${PVR}/CONTENTS | grep "obj /etc/gconf/schemas" | sed 's:obj \([^ ]*\) .*:\1:' |while read F; do
			echo "DEBUG::gconf install  ${F}"
			${ROOT}/usr/bin/gconftool-2  --makefile-install-rule ${F}
		done
	fi
}

gnome2_omf_fix() {
	# workaround/patch against omf.make or omf-install/Makefile.in
	# in order to remove redundant scrollkeeper-updates.
	# - <liquidx@gentoo.org>
	
	local omf_makefiles

	omf_makefiles="$@"

	[ -f ${S}/omf-install/Makefile.in ] \
		&& omf_makefiles="${omf_makefiles} ${S}/omf-install/Makefile.in"
	[ -f ${S}/omf.make ] \
		&& omf_makefiles="${omf_makefiles} ${S}/omf.make"

	for omf in ${omf_makefiles}; do
		omfbase=$(basename ${omf})
		einfo "Fixing OMF Makefile: ${omfbase}"
		sed -i -e 's:\(-scrollkeeper-update -p $(localstatedir)/scrollkeeper\)\([ \t\\]*\)$:\1 -o $(DESTDIR)$(omf_dest_dir)\2:' ${omf}
		sed -i -e 's:\(-scrollkeeper-update -p $(scrollkeeper_localstate_dir)\)\([ \t\\]*\)$:\1 -o $(DESTDIR)$(omf_dest_dir)\2:' ${omf}
	done
}

gnome2_scrollkeeper_update() {
	if [ -x ${ROOT}/usr/bin/scrollkeeper-update ] && [ "${SCROLLKEEPER_UPDATE}" = "1" ]
	then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
	fi
}

gnome2_pkg_postinst() {
	gnome2_gconf_install
	gnome2_scrollkeeper_update
}

gnome2_pkg_postrm() {
	gnome2_scrollkeeper_update
}


EXPORT_FUNCTIONS src_compile src_install pkg_postinst pkg_postrm


