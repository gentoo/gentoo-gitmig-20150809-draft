# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
# Released under the GPL
#
DESCRIPTION="Generate a bootable Gentoo live CD. With ability to deploy Gentoo easily. Includes lilo boot time pengiun animation"
HOMEPAGE="http://cdimages.telemetrybox.org/gentoo/"
SRC_URI="http://cdimages.telemetrybox.org/gentoo/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

DEPEND="sys-apps/syslinux"
RDEPEND="app-misc/zisofs-tools app-cdr/cdrtools"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
}
