# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-2.6.8.ebuild,v 1.1 2006/10/19 23:13:56 jokey Exp $

inherit eutils versionator gnome2

DESCRIPTION="Graphical IRC client"
SRC_URI="http://www.xchat.org/files/source/$(get_version_component_range 1-2)/${P}.tar.bz2
	mirror://sourceforge/${PN}/${P}.tar.bz2
	xchatdccserver? ( mirror://gentoo/${PN}-dccserver-0.6.patch.bz2 )"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="perl dbus tcl python ssl mmx ipv6 nls spell xchattext xchatnogtk xchatdccserver"

RDEPEND=">=dev-libs/glib-2.6.0
	!xchatnogtk? ( >=x11-libs/gtk+-2.6.0 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( >=dev-lang/perl-5.6.1 )
	python? ( >=dev-lang/python-2.2 )
	tcl? ( dev-lang/tcl )
	dbus? ( >=sys-apps/dbus-0.35 )
	spell? ( app-text/enchant )
	!<net-irc/xchat-gnome-0.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	use xchatdccserver && epatch "${DISTDIR}"/xchat-dccserver-0.6.patch.bz2

	# use libdir/xchat/plugins as the plugin directory
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:${prefix}/lib/xchat:${libdir}/xchat:' \
			"${S}"/configure{,.in} || die
	fi
}

src_compile() {
	# Added for to fix a sparc seg fault issue by Jason Wever <weeve@gentoo.org>
	if [ ${ARCH} = "sparc" ] ; then
		replace-flags "-O[3-9]" "-O2"
	fi

	# xchat's configure script uses sys.path to find library path
	# instead of python-config (#25943)
	unset PYTHONPATH

	econf \
		--enable-shm \
		$(use_enable ssl openssl) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcl) \
		$(use_enable mmx) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable dbus) \
		$(use_enable spell spell static) \
		$(use_enable xchattext textfe) \
		$(use_enable !xchatnogtk gtkfe) \
		--program-suffix=-2 \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# some magic to create a menu entry for xchat 2
	sed -i \
		-e "s:^Exec=xchat$:Exec=xchat-2:" \
		-e "s:Name=XChat IRC:Name=XChat 2 IRC:" \
		xchat.desktop

	USE_DESTDIR=1 gnome2_src_install || die "make install failed"

	# install plugin development header
	insinto /usr/include/xchat
	doins src/common/xchat-plugin.h || die "doins failed"

	dodoc ChangeLog README* || die "dodoc failed"
}
