HOMEPAGE="http://rox.sourceforge.net"

S=${WORKDIR}/${P}
SRC_URI="http://prdownloads.sourceforge.net/rox/rox-base-1.0.1.tgz
	http://prdownloads.sourceforge.net/rox/${P}.tgz"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.0.3"

src_unpack() {

	unpack rox-base-1.0.1.tgz
	cd ${WORKDIR}/rox-base-1.0.1
	mkdir -p ${D}/usr/share/Choices
	cp -rf MIME-icons/ ${D}/usr/share/Choices/
	cp -rf MIME-info/ ${D}/usr/share/Choices/
	cp -rf MIME-types/ ${D}/usr/share/Choices/
		
}
