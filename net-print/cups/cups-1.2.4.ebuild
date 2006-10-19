# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.2.4.ebuild,v 1.4 2006/10/19 16:23:18 vapier Exp $

inherit autotools eutils flag-o-matic multilib pam

MY_P=${P/_/}

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"
SRC_URI="http://ftp.easysw.com/pub/cups/${PV}/${MY_P}-source.tar.bz2"
#ESVN_REPO_URI="http://svn.easysw.com/public/cups/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ssl slp pam php samba nls dbus tiff png ppds jpeg X"

DEP="pam? ( virtual/pam )
	ssl? ( net-libs/gnutls )
	slp? ( >=net-libs/openslp-1.0.4 )
	dbus? ( || ( sys-apps/dbus-core sys-apps/dbus ) )
	png? ( >=media-libs/libpng-1.2.1 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	php? ( dev-lang/php )
	app-text/libpaper"
DEPEND="${DEP}
	nls? ( sys-devel/gettext )"
RDEPEND="${DEP}
	nls? ( virtual/libintl )
	!virtual/lpr
	>=app-text/poppler-0.4.3-r1
	X? ( x11-misc/xdg-utils )
	"
PDEPEND="
	ppds? ( || (
		(
			net-print/foomatic-filters-ppds
			net-print/foomatic-db-ppds
		)
		net-print/foomatic-filters-ppds
		net-print/foomatic-db-ppds
		net-print/hplip
		media-gfx/gimp-print
		net-print/foo2zjs
		net-print/cups-pdf
	) )
	samba? ( >=net-fs/samba-3.0.8 )
	virtual/ghostscript"
PROVIDE="virtual/lpr"

# upstream includes an interactive test which is a nono for gentoo.
# therefore, since the printing herd has bigger fish to fry, for now,
# we just leave it out, even if FEATURES=test
RESTRICT="test"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp

	enewgroup lpadmin 106
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# upstream does not acknowledge bindnow as a solution
	epatch ${FILESDIR}/cups-1.2.0-bindnow.patch

	# cups does not use autotools "the usual way" and ship a static config.h.in
	eaclocal
	eautoconf
}

src_compile() {
	export DSOFLAGS="${LDFLAGS}"
	econf \
		--with-cups-user=lp \
		--with-cups-group=lp \
		--with-system-groups=lpadmin \
		--localstatedir=/var \
		--with-docdir=/usr/share/cups/html \
		--with-bindnow=$(bindnow-flags) \
		$(use_enable pam) \
		$(use_enable ssl) \
		--enable-gnutls \
		$(use_enable slp) \
		$(use_enable nls) \
		$(use_enable dbus) \
		$(use_enable png) \
		$(use_enable jpeg) \
		$(use_enable tiff) \
		$(use_with php) \
		--enable-libpaper \
		--enable-threads \
		--enable-static \
		--disable-pdftops \
		|| die "econf failed"

	# Install in /usr/libexec always, instead of using /usr/lib/cups, as that
	# makes more sense when facing multilib support.
	sed -i -e 's:SERVERBIN.*:SERVERBIN = $(BUILDROOT)/usr/libexec/cups:' Makedefs
	sed -i -e 's:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN "/usr/libexec/cups":' config.h
	sed -i -e 's:cups_serverbin=.*:cups_serverbin=/usr/libexec/cups:' cups-config

	emake || die "emake failed"
}

src_install() {
	emake BUILDROOT=${D} install || die "emake install failed"
	dodoc {CHANGES{,-1.{0,1}},CREDITS,LICENSE,README}.txt

	# clean out cups init scripts
	rm -rf ${D}/etc/{init.d/cups,rc*,pam.d/cups}
	# install our init scripts
	newinitd ${FILESDIR}/cupsd.init cupsd
	# install our pam script
	pamd_mimic_system cups auth account

	# correct path
	sed -i -e "s:server = .*:server = /usr/libexec/cups/daemon/cups-lpd:" ${D}/etc/xinetd.d/cups-lpd
	# it is safer to disable this by default, bug 137130
	grep -w 'disable' ${D}/etc/xinetd.d/cups-lpd || \
		sed -i -e "s:}:\tdisable = yes\n}:" ${D}/etc/xinetd.d/cups-lpd

	# install pdftops filter
	exeinto /usr/libexec/cups/filter/
	newexe ${FILESDIR}/pdftops.pl pdftops

	keepdir /usr/share/cups/profiles /usr/libexec/cups/driver /var/log/cups \
		/var/run/cups/certs /var/cache/cups /var/spool/cups/tmp

	# .desktop handling. X useflag. xdg-open from freedesktop is preferred
	if use X; then
		sed -i -e "s:htmlview:xdg-open:" ${D}/usr/share/applications/cups.desktop
	else
		rm -r ${D}/usr/share/applications
	fi
}

pkg_preinst() {
	# cleanups
	[ -n "${PN}" ] && rm -fR ${ROOT}/usr/share/doc/${PN}-*
}

pkg_postinst() {
	einfo "Remote printing: change "
	einfo "Listen localhost:631"
	einfo "to"
	einfo "Listen *:631"
	einfo "in /etc/cups/cupsd.conf"
	einfo
	einfo "For more information about installing a printer take a look at:"
	einfo "http://www.gentoo.org/doc/en/printing-howto.xml."

	local good_gs=false
	for x in app-text/ghostscript-gpl app-text/ghostscript-gnu app-text/ghostscript-esp; do
		if has_version ${x} && built_with_use ${x} cups; then
			good_gs=true
			break
		fi
	done;
	if ! ${good_gs}; then
		ewarn
		ewarn "You need to emerge ghostscript with the \"cups\" USE flag turned on"
	fi
	if has_version =net-print/cups-1.1*; then
		ewarn
		ewarn "The configuration changed with cups-1.2, you may want to save the old"
		ewarn "one and start from scratch:"
		ewarn "# mv /etc/cups /etc/cups.orig; emerge -va1 cups"
		ewarn
		ewarn "You need to rebuild kdelibs for kdeprinter to work with cups-1.2"
	fi
	if [ -e ${ROOT}/usr/lib/cups ]; then
		ewarn
		ewarn "/usr/lib/cups exists - You need to remerge every ebuild that"
		ewarn "installed into /usr/lib/cups and /etc/cups, qfile is in portage-utils:"
		ewarn "# FEATURES=-collision-protect emerge -va1 \$(qfile -qC /usr/lib/cups /etc/cups | sed \"s:net-print/cups$::\")"
		ewarn
		ewarn "FEATURES=-collision-protect is needed to overwrite the compatibility"
		ewarn "symlinks installed by this package, it wont be needed on later merges."
		ewarn "You should also run revdep-rebuild"

		# place symlinks to make the update smoothless
		for i in ${ROOT}/usr/lib/cups/{backend,filter}/*; do
			if [ "${i/\*}" == "${i}" ] && ! [ -e ${i/lib/libexec} ]; then
				ln -s ${i} ${i/lib/libexec}
			fi
		done
	fi
}
