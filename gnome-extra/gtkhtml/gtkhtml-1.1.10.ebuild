# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-1.1.10.ebuild,v 1.3 2003/04/28 23:40:05 liquidx Exp $

IUSE="nls gnome"

inherit gnome.org libtool

MY_PV="`echo ${PV} | cut -d. -f1,2`"
S="${WORKDIR}/${P}"
DESCRIPTION="Lightweight HTML rendering/printing/editing engine."
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
# This one lets gtkhtml-1.0 compiled stuff work, but some stuff do
# not compile, so not sure as to what to set SLOT to .. it could be
# that new versions will support 1.[12] of gtkhtml ...
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

# peg gtkhtml at gal-0.23 because it might get confused with gal-1.99
RDEPEND="=gnome-extra/gal-0.24*
	<gnome-base/control-center-1.99.0
	>=gnome-base/libghttp-1.0.9-r1
	>=dev-libs/libunicode-0.4-r1
	>=gnome-base/gnome-print-0.34
	>=gnome-base/bonobo-1.0.20
	nls? ( sys-devel/gettext
	>=dev-util/intltool-0.11 )
	<gnome-base/libglade-0.99.0
	<gnome-base/gconf-1.1.0"
#	gnome? ( <gnome-base/gconf-1.1.0 )
# Borks without gconf in most cases

DEPEND="${RDEPEND}"

src_compile() {
	elibtoolize

	local myconf=
	
	use nls || {
		myconf="${myconf} --disable-nls"

		mkdir -p ${S}/intl
		touch ${S}/intl/libgettext.h
	}

	# Evo users need to have bonobo support
	#use bonobo \
	#	&& myconf="${myconf} --with-bonobo" \
	#	|| myconf="${myconf} --without-bonobo"

	# Otherwise it will use the wrong include dir
	#use gnome \
	#	&& myconf="${myconf} --with-gconf" \
	#	|| myconf="${myconf} --without-gconf"
	myconf="${myconf} --with-gconf"
# Borks without gconf in most cases

  	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

  	emake || die "Package building failed."
}

# This function converts a pkgconfig config type file to
# a Conf.sh type file used by gnome-config.
#
#   Usage:  conv_pkgconfig_confsh foo.pc
#
# <azarah@gentoo.org> (9 Nov 2002)
conv_pkgconfig_confsh() {

	local pkgconfig_file="$1"
	local confsh_file="${pkgconfig_file%%-*}Conf.sh"
	local package_name="`echo ${pkgconfig_file%%-*} | awk '{print toupper($0)}'`"
	local tmpfile="${T}/$$.env"

	[ "$#" -ne 1 ] && return 1
	[ ! -f ${D}/usr/lib/pkgconfig/${pkgconfig_file} ] && return 1

	# Remove bogus info and convert to bash type file we can
	# source ...
	sed -e 's|: *|=|g' \
		-e '/^$/ d' \
		-e 's|$|"|g' \
		-e 's|=|="|g' \
		-e 's|Libs=|libs=|' \
		-e 's|Cflags=|cflags=|' \
		-e '/^Name.*/ d' \
		-e '/^Description.*/ d' \
		-e '/^Version.*/ d' \
		${D}/usr/lib/pkgconfig/${pkgconfig_file} > ${tmpfile}

	source ${tmpfile}

	# Ok, generate our Conf.sh file
    cat > ${D}/usr/lib/${confsh_file} <<CONFSHEND
#
# Configuration file for using the ${package_name} library in GNOME applications
#
${package_name}_LIBDIR="-L${libdir}"
${package_name}_LIBS="${libs}"
${package_name}_INCLUDEDIR="${cflags}"
${package_name}_DATADIR="${gtkhtml_datadir}"
MODULE_VERSION="${module_version}"

CONFSHEND

	# Fix permissions
	fperms 0755 /usr/lib/${confsh_file}
}

src_install() {
	local fullname=""
	
	einstall || die

	# Fix the double entry in Control Center
	rm -f ${D}/usr/share/control-center/capplets/gtkhtml-properties.desktop

	# This next big gets gtkhtml-1.1 to be compadible with gtkhtml-1.0.
	# We basically generate a /usr/lib/gtkhtmlConf.sh so that gnome-config
	# will see gtkhtml-1.1 and other older gnome apps should then be able
	# to use it.  We also create libgtkhtml.so and libgtkhtml.so.20 symlinks,
	# and /usr/share/gtkhtml-1.1/gtkhtml symlinks for apps compiled against
	# older gtkhtml to find their libs, and data .idl files.
	#
	# <azarah@gentoo.org> (9 Nov 2002)
	conv_pkgconfig_confsh ${PN}-${MY_PV}.pc

	# Add some type of backward compat for libs...
	fullname="`eval basename \`readlink ${D}/usr/lib/lib${PN}-${MY_PV}.so\``"
	dosym ${fullname##*/} /usr/lib/lib${PN}.so
	dosym ${fullname##*/} /usr/lib/lib${PN}.so.20

	# For older apps to be able to find the data...
	dosym '.' /usr/share/${PN}-${MY_PV}/${PN}

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
}

