# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/e2fsprogs/e2fsprogs-1.37.ebuild,v 1.1 2005/03/22 23:46:26 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Standard EXT2 and EXT3 filesystem utilities"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls static diet uclibc"

RDEPEND="diet? ( dev-libs/dietlibc )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix a cosmetic error in mk_cmds's help output.
	epatch "${FILESDIR}"/e2fsprogs-1.32-mk_cmds-cosmetic.patch
	# Patch to make the configure and sed scripts more friendly to, 
	# for example, the Estonian locale
	epatch "${FILESDIR}"/e2fsprogs-1.36-sed-locale.patch
	chmod u+w po/*.po # Userpriv fix #27348
	# Clean up makefile to suck less
	epatch "${FILESDIR}"/e2fsprogs-1.36-makefile.patch

	# kernel headers use the same defines as e2fsprogs and can cause issues #48829
	sed -i \
		-e 's:CONFIG_JBD_DEBUG:__CONFIG_JBD_DEBUG__E2FS:g' \
		$(grep -rl CONFIG_JBD_DEBUG *) \
		|| die "sed jbd debug failed"

	# building e2fsprogs on sparc results in silo breaking
	[[ ${ARCH} == "sparc" ]] && filter-flags -fstack-protector

	# Keep the package from doing silly things
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true
}

src_compile() {
	local myconf
	use diet && myconf="${myconf} --with-diet-libc"
	econf \
		--bindir=/bin \
		--sbindir=/sbin \
		--enable-elf-shlibs \
		--with-ldopts="${LDFLAGS}" \
		$(use_enable !static dynamic-e2fsck) \
		--without-included-gettext \
		$(use_enable nls) \
		${myconf} \
		|| die
	if ! use uclibc && grep -qs 'USE_INCLUDED_LIBINTL.*yes' config.{log,status} ; then
		eerror "INTL sanity check failed, aborting build."
		eerror "Please post your ${S}/config.log file as an"
		eerror "attachment to http://bugs.gentoo.org/show_bug.cgi?id=81096"
		die "Preventing included intl cruft from building"
	fi
	# Parallel make sometimes fails
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README RELEASE-NOTES SHLIBS
	docinto e2fsck
	dodoc e2fsck/ChangeLog e2fsck/CHANGES

	# Move shared libraries to /lib/, install static libraries to /usr/lib/,
	# and install linker scripts to /usr/lib/.
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/
	dolib.a lib/*.a || die "dolib.a"
	local x
	cd "${D}"/$(get_libdir)
	for x in *.so ; do
		gen_usr_ldscript ${x} || die "gen ldscript ${x}"
	done

	# move 'useless' stuff to /usr/
	dosbin "${D}"/sbin/mklost+found
	rm -f "${D}"/sbin/mklost+found

	# Install template awk files for compile_et
	insinto /usr/share/et
	doins "${S}"/lib/et/*.awk || die "doins et awk"
	insinto /usr/share/ss
	doins "${S}"/lib/ss/*.awk || die "doins ss awk"
}
