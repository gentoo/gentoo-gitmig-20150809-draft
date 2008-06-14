# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-1.2.1_rc1-r1.ebuild,v 1.1 2008/06/14 16:59:32 mueli Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit autotools libtool eutils virtualx toolchain-funcs flag-o-matic

PATCHVER=0.2
PATCH_P=${PN}-gentoo-patches-${PATCHVER}

DESCRIPTION="Kerberos 5 implementation from KTH"
HOMEPAGE="http://www.h5l.org/"
SRC_URI="http://www.h5l.org/dist/src/snapshots/${P/_rc/rc}.tar.gz
	mirror://gentoo/${PATCH_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb ipv6 ssl threads X pkinit otp" # ldap ldap-shared <- circular dependency

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	>=dev-db/sqlite-3.5.7
	sys-libs/ss
	sys-libs/com_err
	!virtual/krb5"
# Sry for that - still have no cute solution to break circular dependency
# I also want to point at http://www.h5l.org/manual/heimdal-1-1-branch/info/heimdal.html#Using-LDAP-to-store-the-database
# I agree that it's not advicable to use LDAP as backend for kerberos
#	ldap? ( >=net-nds/openldap-2.3.0 )
#	ldap-shared? ( >=net-nds/openldap-2.3.0 )

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.62"
#	>=sys-devel/libtool-2.2"
PROVIDE="virtual/krb5"

GENTOODIR=${WORKDIR}/gentoo
S=${WORKDIR}/${P/_rc/rc}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch "${GENTOODIR}"/patches

	epatch "${FILESDIR}"/heimdal-r23238-kb5_locl_h-wind_h.patch
	epatch "${FILESDIR}"/heimdal-r23235-kb5-libwind_la.patch
	epatch "${FILESDIR}"/heimdal-kdc-sans_pkinit.patch
	epatch "${FILESDIR}"/heimdal-system_sqlite.patch

	AT_M4DIR="cf" eautoreconf
}

src_compile() {
	local myconf=""

#	if use ldap || use ldap-shared ; then
#		myconf="${myconf} --with-openldap=/usr"
#	fi

	econf \
		$(use_with ipv6) \
		$(use_enable berkdb berkeley-db) \
		$(use_enable pkinit pk-init) \
		$(use_with ssl openssl) \
		$(use_with X x) \
		$(use_enable threads pthread-support) \
		$(use_enable otp) \
		--enable-kcm \
		--enable-shared \
		--enable-netinfo \
		--prefix=/usr \
		--libexecdir=/usr/sbin \
		${myconf} || die "econf failed"
#		$(use_enable ldap-shared hdb-openldap-module) \


	local ltversion=`libtool --version |grep 'GNU libtool' |sed -e's/^.*(GNU libtool) \([0-9]\+\.[0-9]\+\(\.[0-9]\+\)\+\) .*$/\1/'`
	local ltmajor=`echo $ltversion |sed -e's/^\([0-9]\+\)\..*$/\1/'`
	local ltminor=`echo $ltversion |sed -e's/^[0-9]\+\.\([0-9]\+\)\..*$/\1/'`
	if [ $ltmajor -lt 2 ] || ( [ $ltmajor -eq 2 ] && [ $ltminor -lt 2 ] ); then
		ewarn "Using old libtool with a quick hack."
		sed -i -e's/ECHO=/echo=/' libtool
	fi

	emake || die "emake failed"

}

src_test() {
	addpredict /proc/fs/openafs/afs_ioctl
	addpredict /proc/fs/nnpfs/afs_ioctl

	if use X ; then
		KRB5_CONFIG="${S}"/krb5.conf Xmake check || die
	else
		KRB5_CONFIG="${S}"/krb5.conf make check || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd,rshd}
	do
		mv "${D}"/usr/share/man/man8/{,k}${i}.8
		mv "${D}"/usr/sbin/{,k}${i}
	done

	for i in {rcp,rsh,telnet,ftp,su,login}
	do
		mv "${D}"/usr/share/man/man1/{,k}${i}.1
		mv "${D}"/usr/bin/{,k}${i}
	done

	mv "${D}"/usr/share/man/man5/{,k}ftpusers.5
	mv "${D}"/usr/share/man/man5/{,k}login.access.5

	doinitd "${GENTOODIR}"/configs/heimdal-kdc
	doinitd "${GENTOODIR}"/configs/heimdal-kadmind
	doinitd "${GENTOODIR}"/configs/heimdal-kpasswdd
	doinitd "${GENTOODIR}"/configs/heimdal-kcm

	insinto /etc
	newins "${GENTOODIR}"/configs/krb5.conf krb5.conf.example

	sed -i "s:/lib:/$(get_libdir):" "${D}"/etc/krb5.conf.example || die "sed failed"

#	if use ldap; then
#		insinto /etc/openldap/schema
#		doins "${GENTOODIR}"/configs/krb5-kdc.schema
#	fi

	# default database dir
	keepdir /var/heimdal
}
