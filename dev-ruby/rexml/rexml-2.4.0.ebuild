
S=${WORKDIR}/${PN}
DESCRIPTION="Ruby Electric XML"
SRC_URI="http://www.germane-software.com/archives/${PN}_${PV}.tgz"
HOMEPAGE="http://www.germane-software.com/software/rexml/"
DEPEND=">=dev-lang/ruby-1.6.0"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

src_unpack () {
	unpack ${A}
	cd ${S}/bin
	patch < ${FILESDIR}/${P}-gentoo.diff || die
}

src_install () {
	PORTAGETMP=${D} ruby bin/install.rb
}
