# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.8.0.ebuild,v 1.3 2004/03/30 22:37:31 foser Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome default windowmanager"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"
IUSE="xinerama"

# not parallel-safe; see bug #14405
MAKEOPTS="${MAKEOPTS} -j1"

# sharp gtk dep is for a certain speed patch
RDEPEND="virtual/x11
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2.0-r1
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	sys-devel/autoconf"
#autoconf for the config patch only

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README *txt"

G2CONF="${G2CONF} $(use_enable xinerama)"

src_unpack() {

	unpack ${A}
	cd ${S}

	# fix the xinerama configure stuff (#46291)
	epatch ${FILESDIR}/${P}-xinerama_config_test.patch
	WANT_AUTOCONF=2.5 autoconf || die

#We can remove that one eventually
	# causes ICE on ppc w/ gcc (still)
#	use ppc && (
#		[ -z "${CC}" ] && CC=gcc
#		if [ "`${CC} -dumpversion | cut -d. -f1,2`" != "2.95" ] ; then
#			patch -p0 < ${FILESDIR}/metacity-2.4.3-ppc-gcc3.2.diff || die "patch failed"
#		fi
#	)


}
