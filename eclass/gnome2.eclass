# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome2.eclass,v 1.8 2002/06/04 07:42:38 blocke Exp $

# Authors:
# Bruce A. Locke <blocke@shivan.org>
# Spidler <spidler@gentoo.org>

# Gnome 2 ECLASS
ECLASS="gnome2"

# DEBUG for Beta
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

# Remove omit-frame-pointer as some useless folks define that all over the place. they should be shot with a 16 gauge slingshot at least :)
# force debug information
export CFLAGS="${CFLAGS/-fomit-frame-pointer/} -g"
export CXXFLAGS="${CXXFLAGS/-fomit-frame-pointer/} -g"

G2CONF="--enable-debug=yes"
SCROLLKEEPER_UPDATE="0"

gnome2_src_compile() {

	# doc keyword for gtk-doc
	use doc && G2CONF="${G2CONF} --enable-gtk-doc" || G2CONF="${G2CONF} --disable-gtk-doc"
	
	# fix those .la files
	if [ "${LIBTOOL_FIX}" = "1" ]
	then
		libtoolize --copy --force
	fi

	econf ${1} ${G2CONF} || die "./configure failure"
	emake || die "compile failure"

}

gnome2_src_install() {

	# we must delay gconf schema installation due to sandbox
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"

	einstall " scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ ${1}"

	# manual document installation
	if [ -n "${DOCS}" ]
	then
		dodoc ${DOCS}
	fi

	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	# only update scrollkeeper if this package needs it
	[ -a ${D}/var/lib/scrollkeeper ] && SCROLLKEEPER_UPDATE="1"

}

gnome2_pkg_postinst() {

	# schema installation
	if [ -n "${SCHEMAS}" ]
	then

		# install/update schemas the hard way
		export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`

		echo ">>> Updating GConf2 Schemas for ${P}"
		for x in $SCHEMAS
		do
			/usr/bin/gconftool-2  --makefile-install-rule \
				/etc/gconf/schemas/${x}
		done
	fi

	if [ -x /usr/bin/scrollkeeper-update ] && [ SCROLLKEEPER_UPDATE = "1" ]
	then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -p /var/lib/scrollkeeper
	fi
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst


