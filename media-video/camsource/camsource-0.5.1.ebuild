DESCRIPTION="Camsource grabs images from a video4linux device and makes them available
			to various plugins for processing or handling. Camsource can also be used 
			as a streaming webcam server."

HOMEPAGE="http://camsource.sourceforge.net/"
SRC_URI="ftp://ftp.sf.net/pub/sourceforge/camsource/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~sparc64 ~ppc ~alpha"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.22 
		>=media-libs/jpeg-6b"
		
RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	
	econf || die
	emake || die
}

src_install() {
	
	einstall 
}

pkg_postinst() {

	einfo ""
	einfo "Please edit the configuration file: "
	einfo "/etc/camsource.conf.example"
	einfo "to your liking."
	einfo ""

}
