# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome2.eclass,v 1.2 2002/06/01 03:09:29 blocke Exp $

# Authors:
# Bruce A. Locke <blocke@shivan.org>
# Spidler <spidler@gentoo.org>

# Gnome 2 ECLASS
ECLASS="gnome2"

# DEBUG for Beta
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

G2CONF="--enable-debug=yes"

gnome2_src_compile() {

	use doc && G2CONF="${G2CONF} --enable-gtk-doc" || G2CONF="${G2CONF} --disable-gtk-doc"
	
	if [ ${LIBTOOL_FIX} -eq 1 ]
	then
		libtoolize --copy --force
	fi

	econf "${1} --enable-debug=yes" || die "./configure failure"
	emake || die "compile failure"

}

gnome2_src_install() {

	einstall ${1}

	# manual document installation
	if [ -n "${DOC}" && use doc ]
	then
		dodoc ${DOC}
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

EXPORT_FUNCTIONS src_compile src_install pkg_postinst


