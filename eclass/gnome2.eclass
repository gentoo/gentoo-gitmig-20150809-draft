# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome2.eclass,v 1.1 2002/06/01 02:55:47 blocke Exp $

# Gnome 2 ECLASS
ECLASS="gnome2"

# DEBUG for Beta
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


gnome2_src_compile() {

	libtoolize --copy --force

	econf "${1} --enable-debug=yes" || die "./configure failure"
	emake || die "compile failure"

}

gnome2_src_install() {

	einstall ${1}

	# manual document installation
	if [ -n "${DOC}" && use doc ]
	then
		for x in $DOC; do dodoc $x; done
	fi

}

gnome2_pkg_postinst() {

	# manual schema installation
	if [ -n "${SCHEMA}" ]
	then
		for x in $SCHEMA
		do
			/usr/bin/gconftool-2  --makefile-install-rule \
				/etc/gconf/schemas/${SCHEMA}
		done
	fi
}




