# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aiccu/aiccu-2005.01.31.ebuild,v 1.1 2005/03/27 17:34:09 gmsoft Exp $


DESCRIPTION="AICCU Client to configure an IPv6 tunnel to SixXS."
HOMEPAGE="http://www.sixxs.net/"
SRC_URI="http://www.sixxs.net/archive/sixxs/aiccu/unix/aiccu_${PV}.tar.gz"

LICENSE="AICCU"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/aiccu


src_compile() {
	cd ${S}
	export RPM_OPT_FLAGS=${CFLAGS}
	make  || die "Build Failed"
}

src_install() {
	dosbin unix-console/aiccu
	insopts -m 600
	insinto /etc
	doins doc/aiccu.conf
	dodoc doc/{HOWTO,LICENSE,README,changelog}
	exeinto /etc/init.d
	newexe doc/aiccu.init.gentoo aiccu


}

pkg_postinst() {
	einfo "The aiccu ebuild installs an init script named 'aiccu'"
	einfo "To add support for a SixXS connection at startup, do"
	einfo "edit your /etc/aiccu.conf and do"
	einfo "# rc-update add aiccu default"

}

