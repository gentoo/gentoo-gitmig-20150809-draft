S="${WORKDIR}/${P}"
DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

SLOT="0"
LICENSE="Sendmail"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install () {
	dobin altermime 
	dodoc CHANGELOG INSTALL LICENSE README TODO
}
