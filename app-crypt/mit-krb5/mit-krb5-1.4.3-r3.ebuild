# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.4.3-r3.ebuild,v 1.6 2006/08/10 13:12:36 weeve Exp $

inherit eutils flag-o-matic versionator autotools

MY_P=${P/mit-}
P_DIR=$(get_version_component_range 1-2)
S=${WORKDIR}/${MY_P}/src
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/${P_DIR}/${MY_P}-signed.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
IUSE="krb4 static tcl ipv6 doc"

RDEPEND="!virtual/krb5
	sys-libs/com_err
	sys-libs/ss
	tcl? ( dev-lang/tcl )"

DEPEND="${RDEPEND}
	doc? ( virtual/tetex )"

PROVIDE="virtual/krb5"

src_unpack() {
	unpack ${MY_P}-signed.tar
	unpack ./${MY_P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PN}-lazyldflags.patch
	epatch ${FILESDIR}/${PN}-robustgnu.patch
	epatch ${FILESDIR}/${PN}-pthreads.patch
	epatch ${FILESDIR}/${PN}-setupterm.patch
	epatch ${FILESDIR}/${P}-setuid.patch
	ebegin "Reconfiguring configure scripts (be patient)"
	cd ${S}/appl/telnet
	eautoconf --force -I ${S}
	sed -i 's/^# \(@lib\(obj\)\?_frag@\)/\1/' libtelnet/Makefile.in
	eend $?
}

src_compile() {
	econf \
		$(use_with krb4) \
		$(use_with tcl) \
		$(use_enable ipv6) \
		$(use_enable static) \
		--enable-shared \
		--with-system-et --with-system-ss \
		--enable-dns-for-realm || die

	emake -j1 || die

	if use doc ; then
		cd ../doc
		for dir in api implement ; do
			( cd ${dir} ; make ) || die
		done
	fi
}

src_test() {
	einfo "Testing is being debugged, disabled for now"
}

src_install() {
	make \
		DESTDIR=${D} \
		EXAMPLEDIR=/usr/share/doc/${PF}/examples \
		install || die

	cd ..
	dodoc README
	dodoc doc/*.ps
	doinfo doc/*.info*
	dohtml -r doc/*

	use doc && dodoc doc/{api,implement}/*.ps

	for i in {telnetd,ftpd} ; do
		mv ${D}/usr/share/man/man8/${i}.8 ${D}/usr/share/man/man8/k${i}.8
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done

	for i in {rcp,rlogin,rsh,telnet,ftp} ; do
		mv ${D}/usr/share/man/man1/${i}.1 ${D}/usr/share/man/man1/k${i}.1
		mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
	done

	newinitd ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc

	insinto /etc
	newins /usr/share/doc/${PF}/examples/krb5.conf krb5.conf.example
	newins /usr/share/doc/${PF}/examples/kdc.conf kdc.conf.example
}

pkg_postinst() {

	einfo "See /usr/share/doc/${PF}/html/krb5-admin/index.html for documentation."
	echo ""
	echo ""
	ewarn "PLEASE READ THIS"
	ewarn "This release of mit-krb5 now depends on an external version"
	ewarn "of the com_err library.  Please make sure to run revdep-rebuild"
	ewarn "to ensure the integrity of the linking on your system"
	echo ""
	epause 10
	ebeep

}
