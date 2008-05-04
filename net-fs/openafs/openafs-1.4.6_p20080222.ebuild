# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.4.6_p20080222.ebuild,v 1.4 2008/05/04 13:41:50 maekke Exp $

inherit flag-o-matic eutils toolchain-funcs versionator pam

PATCHVER=0.14
MY_PV_DATE=${PV#*_p}
MY_PV=${PV%_p*}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The OpenAFS distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${PN}/${MY_PV}/${MY_P}-src.tar.bz2
	doc? ( http://openafs.org/dl/${PN}/${MY_PV}/${MY_P}-doc.tar.bz2 )
	mirror://gentoo/${PN}-gentoo-${PATCHVER}.tar.bz2
	mirror://gentoo/${PN}-${MY_PV}-cvs${MY_PV_DATE}.patch.bz2"

LICENSE="IBM openafs-krb5 openafs-krb5-a APSL-2 sun-rpc"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="debug kerberos pam doc"

RDEPEND="~net-fs/openafs-kernel-${PV}
	pam? ( sys-libs/pam )
	kerberos? ( virtual/krb5 )"

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)
CONFDIR=${WORKDIR}/gentoo/configs
SCRIPTDIR=${WORKDIR}/gentoo/scripts

src_unpack() {
	unpack ${A}; cd "${S}"

	# Apply patches to apply chosen compiler settings, fix the hardcoded paths
	# to be more FHS friendly, and the fix the incorrect typecasts for va_arg
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	# patch up to the specified cvs version
	epatch "${DISTDIR}"/${MY_P}-cvs${MY_PV_DATE}.patch.bz2

	# enable UCONTEXT on alpha
	epatch "${FILESDIR}"/openafs-alpha-ucontext.patch
	# don't use mapfiles to strip symbols (bug #202489)
	epatch "${FILESDIR}"/openafs-1.4.5-shared-libs.patch

	# disable XCFLAGS override
	sed -i 's/^[ \t]*XCFLAGS.*//' src/cf/osconf.m4
	# disable compiler choice override
	sed -i 's/^[ \t]\+\(CC\|CCOBJ\|MT_CC\)="[^ ]*\(.*\)"/\1="${CC}\2"/' src/cf/osconf.m4

	./regen.sh || die "Failed: regenerating configure script"
}

src_compile() {
	# cannot use "use_with" macro, as --without-krb5-config crashes the econf
	local myconf=""
	if use kerberos; then
		myconf="--with-krb5-conf=$(type -p krb5-config)"
	fi

	# fix linux version at 2.6
	AFS_SYSKVERS=26 \
	XCFLAGS="${CFLAGS}" \
	econf \
		$(use_enable pam) \
		$(use_enable debug) \
		--enable-largefile-fileserver \
		--enable-supergroups \
		--disable-kernel-module \
		${myconf} || die econf

	emake -j1 all_nolibafs || die "Build failed"
}

src_install() {
	make DESTDIR="${D}" install_nolibafs || die "Installing failed"

	# pam_afs and pam_afs.krb have been installed in irregular locations, fix
	if use pam; then
		dopammod "${D}"/usr/$(get_libdir)/pam_afs*
		rm -f "${D}"/usr/$(get_libdir)/pam_afs*
	fi

	# compile_et collides with com_err.  Remove it from this package.
	rm "${D}"/usr/bin/compile_et

	# avoid collision with mit_krb5's version of kpasswd
	(cd "${D}"/usr/bin; mv kpasswd kpasswd_afs)
	use doc && (cd "${D}"/usr/share/man/man1; mv kpasswd.1 kpasswd_afs.1)

	# minimal documentation
	dodoc ${CONFDIR}/README ${CONFDIR}/CellServDB

	# documentation package
	if use doc; then
		use pam && doman src/pam/pam_afs.5

		cp -pPR doc/* "${D}"/usr/share/doc/${PF}
	fi

	# Gentoo related scripts
	newconfd ${CONFDIR}/openafs-client openafs-client
	newconfd ${CONFDIR}/openafs-server openafs-server
	newinitd ${SCRIPTDIR}/openafs-client openafs-client
	newinitd ${SCRIPTDIR}/openafs-server openafs-server

	# used directories: client
	keepdir /etc/openafs
	keepdir /var/cache/openafs

	# used directories: server
	keepdir /etc/openafs/server
	diropts -m0700
	keepdir /var/lib/openafs
	keepdir /var/lib/openafs/db
	diropts -m0755
	keepdir /var/lib/openafs/logs

	# link logfiles to /var/log
	dosym ../lib/openafs/logs /var/log/openafs
}

pkg_preinst() {
	## Somewhat intelligently install default configuration files
	## (when they are not present)
	# CellServDB
	if [ ! -e "${ROOT}"etc/openafs/CellServDB ] \
		|| grep "GCO Public CellServDB" "${ROOT}"etc/openafs/CellServDB &> /dev/null
	then
		cp ${CONFDIR}/CellServDB "${D}"etc/openafs
	fi
	# cacheinfo: use a default location cache, 200 megabyte in size
	# (should be safe for about any root partition, the user can increase
	# the size as required)
	if [ ! -e "${ROOT}"etc/openafs/cacheinfo ]; then
		echo "/afs:/var/cache/openafs:200000" > "${D}"etc/openafs/cacheinfo
	fi
	# ThisCell: default to "openafs.org"
	if [ ! -e "${ROOT}"etc/openafs/ThisCell ]; then
		echo "openafs.org" > "${D}"etc/openafs/ThisCell
	fi
}

pkg_postinst() {
	elog
	elog "This installation should work out of the box (at least the"
	elog "client part doing global afs-cell browsing, unless you had"
	elog "a previous and different configuration).  If you want to"
	elog "set up your own cell or modify the standard config,"
	elog "please have a look at the Gentoo OpenAFS documentation"
	elog "(warning: it is not yet up to date wrt the new file locations)"
	elog
	elog "The documentation can be found at:"
	elog "  http://www.gentoo.org/doc/en/openafs.xml"
}
