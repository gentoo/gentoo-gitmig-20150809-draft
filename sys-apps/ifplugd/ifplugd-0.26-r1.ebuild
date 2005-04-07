# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.26-r1.ebuild,v 1.2 2005/04/07 16:57:54 blubb Exp $

inherit eutils

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://0pointer.de/lennart/projects/ifplugd/"
SRC_URI="http://0pointer.de/lennart/projects/ifplugd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc"

DEPEND="dev-util/pkgconfig
	doc? ( www-client/lynx )"
RDEPEND=">=dev-libs/libdaemon-0.5"

# Gentoo-provided scripts. Version is for the scripts, not ifplugd.
INITSCRIPT=${FILESDIR}/gentoo-ifplugd-init-v3
ACTIONSCRIPT=${FILESDIR}/gentoo-ifplugd.action-v2
CONFFILE=${FILESDIR}/gentoo-ifplugd-conf-v3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	econf $(use_enable doc lynx) \
		--with-initdir=/etc/init.d \
		--disable-xmltoman \
		--disable-subversion \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	newsbin ${ACTIONSCRIPT} ifplugd.action

	# Fix init.d configuration
	rm -fr ${D}/etc/ifplugd ${D}/etc/init.d/ifplugd

	insinto /etc/conf.d ; newins ${CONFFILE} ${PN} || die
	exeinto /etc/init.d ; newexe ${INITSCRIPT} ${PN} || die

	cd ${S}/doc
	dodoc README SUPPORTED_DRIVERS
	use doc && dohtml *.{html,css}
}
