# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdockapp/libdockapp-0.5.0-r1.ebuild,v 1.3 2004/10/23 16:20:38 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker Dock Applet Library"
SRC_URI="http://solfertje.student.utwente.nl/~dalroi/libdockapp/files/${P}.tar.bz2"
HOMEPAGE="http://solfertje.student.utwente.nl/~dalroi/libdockapp/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc ppc64"
DEPEND="virtual/x11"
S=${WORKDIR}/${PN/lib/}
FONTDIR="/usr/share/fonts/${PN}-fonts"

src_unpack()
{
	unpack ${A}

	# Remove non existing targets from makefile.in
	# sanitize fonts installation path
	# sanitize examples install. path
	cd ${S}
	epatch ${FILESDIR}/install-paths.patch-0.5.0-r1
}

src_compile()
{
	libtoolize --force --copy
	aclocal
	autoconf

	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	make                                                    \
		DESTDIR=${D}                                        \
		SHAREDIR="${D}/usr/share/doc/${PF}/examples/"       \
		install || die "make install failed"

	dodoc README ChangeLog NEWS AUTHORS
}

pkg_postinst()
{
	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
	einfo "You also need to add the following line to /etc/fonts/local.conf"
	einfo
	einfo "\t <dir>${FONTDIR}</dir>"
	einfo
}

pkg_postrm()
{
	einfo
	einfo "You need to remove following line from 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
	einfo "You also need to remove the following line from /etc/fonts/local.conf"
	einfo
	einfo "\t <dir>${FONTDIR}</dir>"
	einfo
}
