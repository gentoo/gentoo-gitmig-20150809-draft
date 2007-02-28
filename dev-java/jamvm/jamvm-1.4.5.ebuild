# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jamvm/jamvm-1.4.5.ebuild,v 1.1 2007/02/28 14:03:45 betelgeuse Exp $

inherit eutils flag-o-matic multilib java-vm-2

DESCRIPTION="An extremely small and specification-compliant virtual machine."
HOMEPAGE="http://jamvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug ffi"

RDEPEND="~dev-java/gnu-classpath-0.93
	ffi? ( dev-libs/libffi )"
DEPEND="${DEPEND}"
PDEPEND="=dev-java/eclipse-ecj-3.2* dev-java/gjdoc"

#src_unpack() {
#	unpack "${A}"
#	cd "${S}"
	# These come precompiled.
	# configure script uses detects the compiler
	# from PATH. I guess we should compile this from source.
	# Then just make sure not to hit
	# https://bugs.gentoo.org/show_bug.cgi?id=163801
	#rm -v lib/classes.zip || die
#}

src_compile() {
	filter-flags "-fomit-frame-pointer"

	local myc
	use debug && myc="${myc} --enable-trace"
	use ffi && append-flags -L/usr/lib/libffi

	# configure adds "/share/classpath" itself
	# includedir puts jni.h in a package dependent folder
	econf ${myc} \
		$(use_enable ffi) \
		--includedir=/usr/include/${PN} \
		--with-classpath-install-dir=/opt/gnu-classpath-0.93 \
		|| die "configure failed."
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
