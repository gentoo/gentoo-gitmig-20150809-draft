# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jamvm/jamvm-1.4.4-r1.ebuild,v 1.1 2006/12/01 18:38:53 betelgeuse Exp $

inherit eutils flag-o-matic multilib java-vm-2

DESCRIPTION="An extremely small and specification-compliant virtual machine."
HOMEPAGE="http://jamvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="=dev-java/gnu-classpath-0.92*
	dev-libs/libffi"
DEPEND="${DEPEND}"
PDEPEND="=dev-java/eclipse-ecj-3.2* dev-java/gjdoc"

src_compile() {
	filter-flags "-fomit-frame-pointer"

	# configure adds "/share/classpath" itself
	# includedir puts jni.h in a package dependent folder
	local myc="--with-classpath-install-dir=/opt/gnu-classpath-0.92
	           --includedir=/usr/include/${PN}"
	use debug && myc="${myc} --enable-trace"

	econf ${myc} || die "configure failed."
	emake || die "make failed."
}

src_install() {
	emake DESTDIR=${D} install || die "installation failed."

	dodoc ACKNOWLEDGEMENTS AUTHORS ChangeLog NEWS README \
		|| die "dodoc failed"

	set_java_env

	dodir /opt/${P}/bin
	dosym /usr/bin/jamvm /opt/${P}/bin/java
	dosym /usr/bin/ecj-3.2 /opt/${P}/bin/javac
	dosym /usr/bin/gjdoc /opt/${P}/bin/javadoc
}
