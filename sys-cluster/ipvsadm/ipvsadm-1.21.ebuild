
DESCRIPTION="The main goal of the keepalived project is to add a strong & robust keepalive facility to the Linux Virtual Server project."
HOMEPAGE="http://keepalived.sourceforge.net"
LICENSE="GPL-2"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

SRC_URI="http://www.linuxvirtualserver.org/software/kernel-2.4/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${P}"

src_compile() {
	cd "${S}"
	make || die
}

src_install() {

	into /
	dosbin ipvsadm
	dosbin ipvsadm-save
	dosbin ipvsadm-restore

	doman ipvsadm.8
	doman ipvsadm-save.8
	doman ipvsadm-restore.8

	exeinto /etc/init.d
	doexe ipvsadm

	einfo ""
									
}
