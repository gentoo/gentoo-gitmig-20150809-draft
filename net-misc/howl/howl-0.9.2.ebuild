# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/howl-0.9.2.ebuild,v 1.5 2004/07/04 10:37:06 eradicator Exp $

inherit eutils

DESCRIPTION="Howl is a cross-platform implementation of the Zeroconf networking standard. Zeroconf brings a new ease of use to IP networking."
HOMEPAGE="http://www.porchdogsoft.com/products/howl/"
SRC_URI="http://www.porchdogsoft.com/download/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
# -amd64: Try later version... 0.9.2 shows ../../include/salt/vtypes.h:127:4: #error "CPU unknown"
KEYWORDS="~x86 ~ppc ~sparc -amd64"
IUSE=""
DEPEND="sys-libs/glibc" # sys-devel/automake - needed if we remove the html docs from /usr/share
RDEPEND="sys-libs/glibc"

S=${WORKDIR}/${P}

src_compile() {
	# If we wanted to remove the html docs in /usr/share/howl....
	#einfo "Removing html docs from build process...."
	#sed -e 's/ docs//' < Makefile.am > Makefile.am.new || die "sed failed"
	#mv Makefile.am.new Makefile.am || die "move failed"
	#aclocal || die "aclocal failed"
	#automake || die "automake failed"

	case "${ARCH}" in
	ppc)
		epatch ${FILESDIR}/${PV}-ppc.patch
		;;
	esac
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dohtml -r docs/

	# doesn't work right now.
	# nifd service loader
	#dodir /etc/conf.d
	#cp ${FILESDIR}/nifd.conf.d ${D}/etc/conf.d/nifd || die "cp nifd.conf.d"
	#dodir /etc/init.d
	#cp ${FILESDIR}/nifd.init.d ${D}/etc/init.d/nifd || die "cp nifd.init.d"
	#fperms a+x ${D}/etc/init.d/nifd

	# mDNSResponder service loader
	dodir /etc/conf.d
	cp ${FILESDIR}/mDNSResponder.conf.d ${D}/etc/conf.d/mDNSResponder || die "cp mDNSResponder.conf.d"
	dodir /etc/init.d
	cp ${FILESDIR}/mDNSResponder.init.d ${D}/etc/init.d/mDNSResponder || die "cp mDNSResponder.init.d"
	fperms a+x ${D}/etc/init.d/mDNSResponder
}
