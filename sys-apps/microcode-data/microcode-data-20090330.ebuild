# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-data/microcode-data-20090330.ebuild,v 1.1 2009/05/02 12:52:52 armin76 Exp $

DESCRIPTION="Intel IA32 microcode update data"
HOMEPAGE="http://urbanmyth.org/microcode/"
SRC_URI="http://downloadmirror.intel.com/14303/eng/microcode-${PV}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /lib/firmware
	newins microcode-${PV}.dat microcode.dat || die
}

pkg_postinst() {
	einfo "The microcode available for Intel CPUs has been updated.  You'll need"
	einfo "to reload the code into your processor.  If you're using the init.d:"
	einfo "/etc/init.d/microcode_ctl restart"
}
