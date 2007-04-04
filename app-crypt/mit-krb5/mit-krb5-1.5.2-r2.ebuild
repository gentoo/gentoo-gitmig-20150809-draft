# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.5.2-r2.ebuild,v 1.2 2007/04/04 02:46:56 seemant Exp $

inherit eutils flag-o-matic versionator autotools

PATCHV="0.1"
MY_P=${P/mit-}
P_DIR=$(get_version_component_range 1-2)
S=${WORKDIR}/${MY_P}/src
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/${P_DIR}/${MY_P}-signed.tar
	mirror://gentoo/${P}-patches-${PATCHV}.tar.bz2"

PATCHDIR="${WORKDIR}/patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="krb4 tcl ipv6 doc"

RDEPEND="!virtual/krb5
	sys-libs/com_err
	sys-libs/ss
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	doc? ( virtual/tetex )"
PROVIDE="virtual/krb5"

src_unpack() {
	unpack ${A}
	unpack ./${MY_P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-lazyldflags.patch
	EPATCH_SUFFIX="patch" epatch "${PATCHDIR}"
	ebegin "Reconfiguring configure scripts (be patient)"
	cd "${S}"/appl/telnet
	eautoconf --force -I "${S}"
	eend $?
}

src_compile() {
	econf \
		$(use_with krb4) \
		$(use_with tcl) \
		$(use_enable ipv6) \
		--enable-shared \
		--with-system-et --with-system-ss \
		--enable-dns-for-realm \
		--enable-kdc-replay-cache || die

	emake -j1 || die

	if use doc ; then
		cd ../doc
		for dir in api implement ; do
			make -C ${dir} || die
		done
	fi
}

src_test() {
	einfo "Testing is being debugged, disabled for now"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		EXAMPLEDIR=/usr/share/doc/${PF}/examples \
		install || die

	keepdir /var/lib/krb5kdc

	cd ..
	dodoc README
	dodoc doc/*.ps
	doinfo doc/*.info*
	dohtml -r doc/*

	use doc && dodoc doc/{api,implement}/*.ps

	for i in {telnetd,ftpd} ; do
		mv "${D}"/usr/share/man/man8/${i}.8 "${D}"/usr/share/man/man8/k${i}.8
		mv "${D}"/usr/sbin/${i} "${D}"/usr/sbin/k${i}
	done

	for i in {rcp,rlogin,rsh,telnet,ftp} ; do
		mv "${D}"/usr/share/man/man1/${i}.1 "${D}"/usr/share/man/man1/k${i}.1
		mv "${D}"/usr/bin/${i} "${D}"/usr/bin/k${i}
	done

	newinitd "${FILESDIR}"/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd "${FILESDIR}"/mit-krb5kdc.initd mit-krb5kdc

	insinto /etc
	newins ${D}/usr/share/doc/${PF}/examples/krb5.conf krb5.conf.example
	newins ${D}/usr/share/doc/${PF}/examples/kdc.conf kdc.conf.example
}

pkg_postinst() {
	elog "See /usr/share/doc/${PF}/html/krb5-admin/index.html for documentation."
}
