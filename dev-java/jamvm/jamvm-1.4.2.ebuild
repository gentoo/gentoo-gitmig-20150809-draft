# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jamvm/jamvm-1.4.2.ebuild,v 1.2 2006/05/01 12:16:37 corsair Exp $

inherit eutils flag-o-matic

DESCRIPTION="An extremely small and specification-compliant virtual machine."
HOMEPAGE="http://jamvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/jamvm/jamvm-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=dev-java/gnu-classpath-0.19"
RDEPEND="${DEPEND}"

src_compile() {
	filter-flags "-fomit-frame-pointer"

	# configure adds "/share/classpath" itself
	# includedir puts jni.h in a package dependent folder
	local myc="--with-classpath-install-dir=/usr
			   --includedir=/usr/include/${PN}"
	use debug && myc="${myc} --enable-trace"
	econf ${myc} || die "configure failed."
	emake || die "make failed."
}

src_install() {
	make install DESTDIR="${D}" || die "installation failed."

	dodoc ACKNOWLEDGEMENTS AUTHORS ChangeLog NEWS README \
		|| die "dodoc failed"
}
