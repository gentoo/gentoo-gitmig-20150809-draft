# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/universalindentgui/universalindentgui-1.1.0-r3.ebuild,v 1.1 2010/07/19 19:43:38 wired Exp $

EAPI="2"

PYTHON_DEPEND="python? 2"

inherit eutils qt4-r2 python

DESCRIPTION="Cross platform compatible GUI for several code formatters, beautifiers and indenters."
HOMEPAGE="http://universalindent.sourceforge.net/"
SRC_URI="mirror://sourceforge/universalindent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug html perl php python ruby xml"

LANGS="de fr ja ru uk zh_TW"

for L in $LANGS; do
	IUSE="$IUSE linguas_$L"
done

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-script:4
	x11-libs/qscintilla"
RDEPEND="${DEPEND}
	dev-util/indent
	dev-util/astyle
	dev-util/bcpp
	html? ( app-text/htmltidy
			perl? ( dev-lang/perl ) )
	perl? ( dev-perl/perltidy )
	php? ( dev-php/PEAR-PHP_Beautifier )
	ruby? ( dev-lang/ruby )
	xml? ( dev-util/xmlindent )
"

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	# .pro fixes
	sed -i "s:lupdate-qt4:lupdate:" UniversalIndentGUI.pro ||
		die ".pro fix failed"
	sed -i "s:lrelease-qt4:lrelease:" UniversalIndentGUI.pro ||
		die ".pro fix failed"
	sed -i "s:ja_jp.qm:ja_JP.qm:" UniversalIndentGUI.pro ||
		die ".pro lang fix failed"
	if use debug; then
		sed -i "s:release,:debug,:g" UniversalIndentGUI.pro ||
			die ".pro debug fix failed"
	fi

	# patch .pro file according to our use flags
	# basic support
	UEXAMPLES="cpp sh"
	UINDENTERS="shellindent.awk"
	UIGUIFILES="shellindent gnuindent bcpp astyle"

	if use html; then
		UEXAMPLES="${UEXAMPLES} html"
		UIGUIFILES="${UIGUIFILES} tidy"
		if use perl; then
			UINDENTERS="${UINDENTERS} hindent"
			UIGUIFILES="${UIGUIFILES} hindent"
		fi
	fi

	if use perl; then
		UEXAMPLES="${UEXAMPLES} pl"
		UIGUIFILES="${UIGUIFILES} perltidy"
	fi

	if use php; then
		UEXAMPLES="${UEXAMPLES} php"
		UINDENTERS="${UINDENTERS} phpStylist.php"
		UIGUIFILES="${UIGUIFILES} php_Beautifier phpStylist"
	fi

	if use python; then
		UEXAMPLES="${UEXAMPLES} py"
		UINDENTERS="${UINDENTERS} pindent.py"
		UIGUIFILES="${UIGUIFILES} pindent"
		python_convert_shebangs -r 2 .
	fi

	if use ruby; then
		UEXAMPLES="${UEXAMPLES} rb"
		UINDENTERS="${UINDENTERS} rbeautify.rb ruby_formatter.rb"
		UIGUIFILES="${UIGUIFILES} rbeautify rubyformatter"
	fi

	if use xml; then
		UEXAMPLES="${UEXAMPLES} xml"
		UIGUIFILES="${UIGUIFILES} xmlindent"
	fi

	IFILES=""
	for I in ${UINDENTERS}; do
		IFILES="${IFILES} indenters/${I}"
		chmod +x indenters/${I}
	done
	for I in ${UIGUIFILES}; do
		IFILES="${IFILES} indenters/uigui_${I}.ini"
	done

	# apply fixes in .pro file
	sed -i "/^unix:indenters.files +=/d" UniversalIndentGUI.pro ||
		die ".pro patching failed"
	sed -i "s:indenters/uigui_\*\.ini:${IFILES}:" UniversalIndentGUI.pro ||
		die ".pro patching failed"

	for lang in ${LANGS}; do
		if [[ ! "${LINGUAS}" =~ "${lang}" ]]; then
			[[ ${lang} == "ja" ]] && lang="ja_JP"
			sed -i "/_${lang}.ts/d" UniversalIndentGUI.pro || die "failed while disabling $lang"
			sed -i "/_${lang}.qm/d" UniversalIndentGUI.pro || die "failed while disabling $lang"
		fi
	done

	epatch "${FILESDIR}"/"${P}"-gcc45.patch
	# bug #325811
	epatch "${FILESDIR}"/"${P}"-astyle_pwd_fix.patch
}

src_configure() {
	eqmake4 UniversalIndentGUI.pro || die "eqmake4 failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc *.txt || die "doc installation failed"
	doman doc/"${PN}".1.gz || die "man page installation failed"
	insinto /usr/share/doc/${PF}/examples
	for I in ${UEXAMPLES}; do
		doins indenters/example.${I}
	done

	doicon resources/universalIndentGUI.png

	make_desktop_entry universalindentgui UniversalIndentGUI universalIndentGUI \
		"Qt;Development" || die "menu installation failed"
}
