
DESCRIPTION="Partition table rescue/guessing tool"
SRC_URI="http://www.stud.uni-hannover.de/user/76201/gpart/${P}.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/user/76201/gpart/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S} ; epatch ${FILESDIR}/${P}-errno.diff
}

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin src/gpart

	doman man/gpart.8

	dodoc README CHANGES COPYING INSTALL LSM
}

