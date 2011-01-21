# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opencryptoki/opencryptoki-2.3.3-r2.ebuild,v 1.5 2011/01/21 03:26:42 flameeyes Exp $

EAPI="2"

# backports are maintained as tags on Diego's repository on gitorious:
# http://gitorious.org/~flameeyes/opencryptoki/flameeyess-opencryptoki
BACKPORTS=3

inherit autotools eutils multilib flag-o-matic

DESCRIPTION="PKCS#11 provider cryptographic hardware"
HOMEPAGE="http://sourceforge.net/projects/opencryptoki"
SRC_URI="mirror://sourceforge/opencryptoki/${P}.tar.bz2
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.bz2}"

# Upstream is looking into relicensing it into CPL-1.0 entirely; the CCA
# token sources are under CPL-1.0 already.
LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="tpm? ( app-crypt/trousers )
		 dev-libs/openssl"
DEPEND="${RDEPEND}"

IUSE="+tpm debug"

# tests right now basically don't exist; the only available thing would
# test against an installed copy and would kill a running pcscd, all
# things that we're not interested to.
RESTRICT=test

pkg_setup() {
	enewgroup pkcs11
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_MULTI_MSG="Applying backports patches #${BACKPORTS} ..." \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	eautoreconf
}

src_configure() {
	# package uses ${localstatedir}/lib as the default path, so if we
	# leave it to econf, it'll create /var/lib/lib.

	# Since upstream by default seem to enable any possible token, even
	# when they don't seem to be used, we limit ourselves to the
	# software emulation token (swtok) and if the user enabled the tpm
	# USE flag, tpmtok.  The rest of the tokens seem to be hardware- or
	# software-dependent even when they build fine without their
	# requirements, but until somebody asks for those, I'd rather not
	# enable them.

	# We don't use --enable-debug because that tinkers with the CFLAGS
	# and we don't want that. Instead we append -DDEBUG which enables
	# debug information.
	use debug && append-flags -DDEBUG

	econf \
		--localstatedir=/var \
		--enable-fast-install \
		--disable-dependency-tracking \
		--disable-debug \
		--enable-daemon \
		--enable-library \
		--disable-icatok \
		--enable-swtok \
		$(use_enable tpm tpmtok) \
		--disable-aeptok \
		--disable-bcomtok \
		--disable-ccatok \
		--disable-crtok \
		--disable-icctok \
		--disable-pkcscca_migrate
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	# doesn't use libltdl; only dlopen()-based interfaces
	find "${D}" -name '*.la' -delete

	# We replace their ld.so and init files (mostly designed for RedHat
	# as far as I can tell) with our own replacements.
	rm -rf "${D}"/etc/ld.so.conf.d "${D}"/etc/rc.d

	# make sure that we don't modify the init script if the USE flags
	# are enabled for the needed services.
	sed \
		-e "$(use tpm && echo 'p' || echo '/use tcsd/d')" \
		"${FILESDIR}/pkcsslotd.init.2" \
		> "${T}"/pkcsslotd.init || die

	newinitd "${T}/pkcsslotd.init" pkcsslotd

	dodir /etc/env.d
	cat - > "${D}"/etc/env.d/50${PN} <<EOF
LDPATH=/usr/$(get_libdir)/opencryptoki:/usr/$(get_libdir)/opencryptoki/stdll
EOF

	dodoc README AUTHORS FAQ TODO doc/openCryptoki-HOWTO.pdf || die
}
